/**
 * Portal 2 HTML DOM Builder
 * ========================
 * This script allows creating HTML DOM elements in Portal 2 using weighted cubes.
 * Elements are represented by colored cubes, and modifiers are represented by grey cubes.
 */

if (!("Entities" in this)) return;

// Include required dependencies
IncludeScript("ppmod");
IncludeScript("sl_httportal");
IncludeScript("domtypes");

// Constants
const CUBE_SPACING = 18.0;
const CHUNK_SIZE = 2048;
const ERROR_DISPLAY_TIME = 2.0;
const SUCCESS_DISPLAY_TIME = 1.0;

// Global script scope
::script <- {};

/**
 * Utility Functions
 * ================
 */

/**
 * Displays a message to the player
 * @param message The message to display
 * @param color The RGB color string
 * @param size The text size
 * @param duration The display duration
 */
function DisplayMessage(message, color = "255 0 0", size = 2, duration = ERROR_DISPLAY_TIME) {
    local text = ppmod.text(message, -1, 0.3);
    text.SetColor(color);
    text.SetSize(size);
    text.Display(duration);
}

/**
 * Creates a particle effect at a position
 * @param position The position to create the effect at
 * @param parent The parent entity
 */
function CreateParticleEffect(position, parent = null) {
    local particle = Entities.CreateByClassname("info_particle_system");
    particle.SetOrigin(position);
    particle.SetAngles(0, 0, 0);
    if (parent) particle.SetParent(parent);
    particle.__KeyValueFromString("effect_name", "portal_2_effects.particles");
    particle.__KeyValueFromString("start_active", "1");
    EntFireByHandle(particle, "Start", "", 0, null, null);
    EntFireByHandle(particle, "Kill", "", 1, null, null);
}

/**
 * Core Functions
 * =============
 */

/**
 * Spawns a cube that can be held by the player
 * @param pos Optional position to spawn the cube at
 * @return The spawned cube entity
 */
::spawnHeldCube <- async(function (pos = null) {
    if (pplayer.holding()) {
        DisplayMessage("Player is already holding a cube!");
        return;
    }

    yield ppmod.give({ prop_weighted_cube = 1 });
    local cube = yielded.prop_weighted_cube[0];
    
    yield ppmod.wait(null, 0.01);
    cube.__KeyValueFromString("model", "models/props/metal_box.mdl");

    if (pos) {
        cube.SetOrigin(pos);
    } else {
        cube.Use("", 0.0, GetPlayer(), GetPlayer());
    }

    SendToConsole("ent_messages " + cube.entindex());
    return cube;
});

/**
 * Creates a new DOM element cube
 * @param type The element type (string or enum)
 * @param pos Optional position to spawn at
 */
::newElement <- async(function (type, pos = null) {
    if (!(typeof type == "string") && !(abs(type) in DOM_ELEMENTS)) {
        DisplayMessage("Invalid element type!");
        return;
    }

    yield spawnHeldCube(pos);
    local cube = yielded;
    local scope = cube.GetScriptScope();
    scope._domType <- type;

    if (typeof type == "string") {
        cube.targetname = type;
        cube.Color("120 120 120");
    } else {
        local absType = abs(type);
        if (absType >= 0 && absType < DOM_ELEMENTS.len()) {
            cube.Color(DOM_COLORS[absType]);
            cube.targetname = "<" + (type < 0 ? "/" : "") + DOM_ELEMENTS[absType] + ">";
        } else {
            DisplayMessage("Invalid element type enum value: " + type);
            cube.Color("255 0 0");
            cube.targetname = "<INVALID>";
            return;
        }
    }

    local elementName = typeof type == "string" ? "text node" : DOM_ELEMENTS[abs(type)];
    DisplayMessage("Created " + elementName + (type < 0 ? " closing tag" : " opening tag"), "0 255 0", 2, SUCCESS_DISPLAY_TIME);
    CreateParticleEffect(cube.GetOrigin(), cube);
});

/**
 * Creates a new modifier cube
 * @param name The modifier name
 * @param data The modifier value
 * @param pos Optional position to spawn at
 */
::newModifier <- async(function (name, data, pos = null) {
    yield ppmod.give({ prop_weighted_cube = 1 });
    local cube = yielded.prop_weighted_cube[0];

    if (pos) cube.SetOrigin(pos);

    local scope = cube.GetScriptScope();
    scope._domModifier <- name;
    scope._domData <- data;

    cube.Color("80 80 80");
    cube.targetname = name + " = " + data;

    DisplayMessage("Created modifier: " + name + " = \"" + data + "\"", "0 255 0", 2, SUCCESS_DISPLAY_TIME);
    CreateParticleEffect(cube.GetOrigin(), cube);
});

/**
 * HTML Generation Functions
 * =======================
 */

/**
 * Builds the HTML document from cubes in the world
 * @return The generated HTML document
 */
::buildHTTP <- function () {
    local dom = [];
    local cube = null;

    // First pass: collect element cubes
    while (cube = Entities.FindByClassname(cube, "prop_weighted_cube")) {
        local scope = cube.GetScriptScope();
        if (!("_domType" in scope)) continue;

        dom.push({
            pos = cube.GetOrigin(),
            type = scope._domType,
            modifiers = {}
        });
    }

    // Second pass: collect modifier cubes
    cube = null;
    while (cube = Entities.FindByClassname(cube, "prop_weighted_cube")) {
        local scope = cube.GetScriptScope();
        if (!("_domModifier" in scope)) continue;

        local pos = cube.GetOrigin();
        foreach (obj in dom) {
            if (fabs(obj.pos.x - pos.x) > CUBE_SPACING) continue;
            if (fabs(obj.pos.y - pos.y) > CUBE_SPACING) continue;
            if (!(scope._domModifier in obj.modifiers)) {
                obj.modifiers[scope._domModifier] <- scope._domData;
            } else {
                obj.modifiers[scope._domModifier] += ";" + scope._domData;
            }
        }
    }

    // Sort DOM elements by position
    dom.sort(function (a, b) {
        if (a.pos.y > b.pos.y + CUBE_SPACING) return -1;
        if (a.pos.y < b.pos.y - CUBE_SPACING) return 1;
        if (a.pos.x > b.pos.x) return 1;
        if (a.pos.x < b.pos.x) return -1;
        return 0;
    });

    // Generate HTML
    local output = "";
    foreach (obj in dom) {
        local modifiers = "";
        foreach (key, value in obj.modifiers) {
            modifiers += key + "=\"" + value + "\" ";
        }

        if (typeof obj.type == "string") {
            output += obj.type;
        } else {
            output += "<" + (obj.type < 0 ? "/" : "") + DOM_ELEMENTS[abs(obj.type)] + " " + modifiers + ">";
        }
    }

    return output;
};

/**
 * Sends the HTML document to the client
 * @param document The HTML document to send
 */
::sendHTTP <- function (document) {
    local contentLength = document.len();
    local newlineCount = 0;
    local i = 0;
    while ((i = document.find("\n", i)) != null) {
        newlineCount++;
        i++;
    }
    contentLength += newlineCount;

    printl(format("HTTP/1.1 200 OK\nServer: Portal 2\nContent-Type: text/html\nContent-Length: %d\n", contentLength));

    local pos = 0;
    local len = document.len();
    
    while (pos < len) {
        local end = min(pos + CHUNK_SIZE, len);
        print(document.slice(pos, end));
        pos = end;
    }

    printl("\n");
    DisplayMessage("HTML document generated and sent to client!", "0 255 0", 2, SUCCESS_DISPLAY_TIME);
};

/**
 * Command Handler
 * =============
 */

/**
 * Creates a cube entity
 * @param type The type of cube to create
 * @param data Optional data for the cube
 * @param pos Optional position to spawn at
 */
::createCube <- async(function (type, data = null, pos = null) {
    if (typeof type == "string") {
        if (type == "TEXT") {
            yield newElement(data, pos);
        } else if (type == "MODIFIER") {
            local colonIndex = data.find(":");
            if (colonIndex == null) {
                DisplayMessage("Invalid modifier format: " + data);
                return;
            }
            local name = data.slice(0, colonIndex).strip();
            local value = data.slice(colonIndex + 1).strip();
            yield newModifier(name, value, pos);
        } else {
            DisplayMessage("Unknown cube string type: " + type);
        }
    } else if (typeof type == "integer") {
        yield newElement(type, pos);
    } else {
        DisplayMessage("Invalid cube type: " + typeof type);
    }
});

// Initialize on map load
ppmod.onauto(function () {
    ::pplayer <- ppmod.player(GetPlayer());

    // Register GET command
    ppmod.alias("GET", function () {
        local document = buildHTTP();
        sendHTTP(document);
    });

    // Enable developer mode for ent_messages
    SendToConsole("developer 1");
    SendToConsole("con_drawnotify 0");

    // Register script command handler
    ::script <- function(cmd) {
        try {
            if (cmd.find("createCube(") == 0 && cmd.slice(-1) == ")") {
                local argsString = cmd.slice(11, -1);
                local args = argsString.split(",");

                local type = null;
                local data = null;
                local pos = null;

                // Parse type argument
                if (args.len() > 0) {
                    local typeStr = args[0].strip();
                    if (typeStr.tointeger().tostring() == typeStr && typeStr.len() > 0) {
                        type = typeStr.tointeger();
                    } else if (typeStr.len() > 1 && typeStr[0] == '"') {
                        type = typeStr.slice(1, -1);
                    } else {
                        local globalValue = getroottable()[typeStr];
                        type = (typeof globalValue == "integer") ? globalValue : typeStr;
                    }
                }

                // Parse data argument
                if (args.len() > 1) {
                    local dataStr = args[1].strip();
                    if (dataStr.len() > 1 && dataStr[0] == '"') {
                        data = dataStr.slice(1, -1);
                    } else if (dataStr == "null") {
                        data = null;
                    } else {
                        if (dataStr.tointeger().tostring() == dataStr) data = dataStr.tointeger();
                        else if (dataStr.tofloat().tostring() == dataStr) data = dataStr.tofloat();
                        else if (dataStr == "true") data = true;
                        else if (dataStr == "false") data = false;
                        else data = dataStr;
                    }
                }

                // Parse position argument
                if (args.len() > 2) {
                    local posStr = args[2].strip();
                    if (posStr.find("Vector(") == 0 && posStr.slice(-1) == ")") {
                        local coordsStr = posStr.slice(7, -1);
                        local coords = coordsStr.split(",");
                        if (coords.len() == 3) {
                            pos = Vector(
                                coords[0].strip().tofloat(),
                                coords[1].strip().tofloat(),
                                coords[2].strip().tofloat()
                            );
                        } else {
                            throw "Invalid Vector format: " + posStr;
                        }
                    } else {
                        throw "Invalid position format: " + posStr;
                    }
                }

                ::createCube(type, data, pos);
            } else {
                DisplayMessage("Unknown command: " + cmd);
            }
        } catch (e) {
            DisplayMessage("Error executing command: " + cmd + ". Error: " + e);
        }
    };
});
