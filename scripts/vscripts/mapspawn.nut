if (!("Entities" in this)) return;

// https://github.com/p2r3/ppmod
IncludeScript("ppmod");
// https://github.com/p2r3/savelock
IncludeScript("sl_httportal");

// Import DOM enums and colors
IncludeScript("domtypes");

// Create a script command table
::script <- {};

// Register functions in the global scope
::spawnHeldCube <- async(function (pos = null) {

  // Check if the player is already holding a cube
  if (pplayer.holding()) return;

  // Spawn a storage cube at the player's feet
  yield ppmod.give({ prop_weighted_cube = 1 });
  local cube = yielded.prop_weighted_cube[0];
  
  // Set the model name explicitly
  cube.__KeyValueFromString("model", "models/props/metal_box.mdl");

  if (pos) {
    // If a position was provided, teleport the cube there
    cube.SetOrigin(pos);
  } else {
    // Otherwise, have the player pick up the cube
    cube.Use("", 0.0, GetPlayer(), GetPlayer());
  }

  // This seems to be the only clean way to draw the cube's name on top of it
  SendToConsole("ent_messages " + cube.entindex());

  return cube;

});

// Register newElement in the global scope
::newElement <- async(function (type, pos = null) {

  // Validate input type
  if (!(typeof type == "string") && !(abs(type) in DOM_ELEMENTS)) {
    // Show error message
    local errorText = ppmod.text("Invalid element type!", -1, 0.3);
    errorText.SetColor("255 0 0");
    errorText.SetSize(2);
    errorText.Display(2);
    return;
  }

  // Spawn a storage cube, get its handle
  yield spawnHeldCube(pos);
  local cube = yielded;

  // Store the cube's type in its script scope
  local scope = cube.GetScriptScope();
  scope._domType <- type;

  if (typeof type == "string") {
    // Special case for raw strings
    cube.targetname = type;
    cube.Color("120 120 120");
  } else {
    // Set the color and display name based on the type
    cube.Color(DOM_COLORS[abs(type)]);
    cube.targetname = "<" + (type < 0 ? "/" : "") + DOM_ELEMENTS[abs(type)] + ">";
  }

  // Show success message
  local elementName = typeof type == "string" ? "text node" : DOM_ELEMENTS[abs(type)];
  local successText = ppmod.text("Created " + elementName + (type < 0 ? " closing tag" : " opening tag"), -1, 0.3);
  successText.SetColor("0 255 0");
  successText.SetSize(2);
  successText.Display(1);

  // Add particle effect
  local particle = Entities.CreateByClassname("info_particle_system");
  particle.SetOrigin(cube.GetOrigin());
  particle.SetAngles(0, 0, 0);
  particle.SetParent(cube);
  particle.__KeyValueFromString("effect_name", "portal_2_effects.particles");
  particle.__KeyValueFromString("start_active", "1");
  EntFireByHandle(particle, "Start", "", 0, null, null);
  EntFireByHandle(particle, "Kill", "", 1, null, null);

});

// Register newModifier in the global scope
::newModifier <- async(function (name, data, pos = null) {

  // Spawn a storage cube at the player's feet
  yield ppmod.give({ prop_weighted_cube = 1 });
  local cube = yielded.prop_weighted_cube[0];

  if (pos) {
    cube.SetOrigin(pos);
  }

  // Store the modifier data in the cube's script scope
  local scope = cube.GetScriptScope();
  scope._domModifier <- name;
  scope._domData <- data;

  // Set cube color and display name
  cube.Color("80 80 80");
  cube.targetname = name + " = " + data;

  // Show success message
  local successText = ppmod.text("Created modifier: " + name + " = \"" + data + "\"", -1, 0.3);
  successText.SetColor("0 255 0");
  successText.SetSize(2);
  successText.Display(1);

  // Add particle effect
  local particle = Entities.CreateByClassname("info_particle_system");
  particle.SetOrigin(cube.GetOrigin());
  particle.SetAngles(0, 0, 0);
  particle.SetParent(cube);
  particle.__KeyValueFromString("effect_name", "portal_2_effects.particles");
  particle.__KeyValueFromString("start_active", "1");
  EntFireByHandle(particle, "Start", "", 0, null, null);
  EntFireByHandle(particle, "Kill", "", 1, null, null);

});

/**
 * Builds the HTML document from the cubes in the world.
 * @returns {string} The generated HTML document as a string.
 */
::buildHTTP <- function () {
  local dom = [];
  local cube = null;

  // First pass: collect all element cubes
  while (cube = Entities.FindByClassname(cube, "prop_weighted_cube")) {
    local scope = cube.GetScriptScope();
    if (!("_domType" in scope)) continue;

    dom.push({
      pos = cube.GetOrigin(),
      type = scope._domType,
      modifiers = {}
    });
  }

  // Second pass: collect all modifier cubes
  cube = null;
  while (cube = Entities.FindByClassname(cube, "prop_weighted_cube")) {
    local scope = cube.GetScriptScope();
    if (!("_domModifier" in scope)) continue;

    local pos = cube.GetOrigin();
    foreach (obj in dom) {
      if (fabs(obj.pos.x - pos.x) > 18.0) continue;
      if (fabs(obj.pos.y - pos.y) > 18.0) continue;
      if (!(scope._domModifier in obj.modifiers)) {
        obj.modifiers[scope._domModifier] <- scope._domData;
      } else {
        obj.modifiers[scope._domModifier] += ";" + scope._domData;
      }
    }
  }

  // Sort DOM elements
  dom.sort(function (a, b) {
    if (a.pos.y > b.pos.y + 18.0) return -1;
    if (a.pos.y < b.pos.y - 18.0) return 1;
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

// Sends the generated HTML document to the client
::sendHTTP <- function (document) {
  // Pre-calculate content length
  local contentLength = document.len();
  local newlineCount = 0;
  local i = 0;
  while ((i = document.find("\n", i)) != null) {
    newlineCount++;
    i++;
  }
  contentLength += newlineCount;

  // Send headers in a single printl call
  printl(format("HTTP/1.1 200 OK\nServer: Portal 2\nContent-Type: text/html\nContent-Length: %d\n", contentLength));

  // Send content in optimized chunks
  local chunkSize = 2048; // Increased chunk size for better performance
  local pos = 0;
  local len = document.len();
  
  while (pos < len) {
    local end = min(pos + chunkSize, len);
    print(document.slice(pos, end));
    pos = end;
  }

  // Send final newlines
  printl("\n");

  // Show success message
  local successText = ppmod.text("HTML document generated and sent to client!", -1, 0.3);
  successText.SetColor("0 255 0");
  successText.SetSize(2);
  successText.Display(2);
};

// Create a cube entity representing a DOM element or modifier
::createCube <- async(function (type, data = null, pos = null) {
  // Determine the type of cube to create based on the 'type' argument
  if (typeof type == "string") {
    if (type == "TEXT") {
      // Create a text node element
      yield newElement(data, pos);
    } else if (type == "MODIFIER") {
      // Create a modifier
      // Parse the modifier string format "name: value"
      local colonIndex = data.find(":");
      if (colonIndex == null) {
        // Handle invalid modifier format
        local errorText = ppmod.text("Invalid modifier format: " + data, -1, 0.3);
        errorText.SetColor("255 0 0");
        errorText.SetSize(2);
        errorText.Display(2);
        return;
      }
      local name = data.slice(0, colonIndex).strip();
      local value = data.slice(colonIndex + 1).strip();
      yield newModifier(name, value, pos);
    } else {
      // Handle unknown string type
      local errorText = ppmod.text("Unknown cube string type: " + type, -1, 0.3);
      errorText.SetColor("255 0 0");
      errorText.SetSize(2);
      errorText.Display(2);
    }
  } else if (typeof type == "integer") {
    // Create a DOM element using the enum value
    yield newElement(type, pos);
  } else {
    // Handle invalid type
    local errorText = ppmod.text("Invalid cube type: " + typeof type, -1, 0.3);
    errorText.SetColor("255 0 0");
    errorText.SetSize(2);
    errorText.Display(2);
  }
});

ppmod.onauto(function () {
  ::pplayer <- ppmod.player(GetPlayer());

  // Register the "GET" command to build and send the HTML document
  ppmod.alias("GET", function () {
    local document = buildHTTP();
    sendHTTP(document);
  });

  // Required for ent_messages to work
  SendToConsole("developer 1");
  SendToConsole("con_drawnotify 0");

  // Register the script command
  ::script <- function(cmd) {
    try {
      // Handle createCube commands
      if (cmd.find("createCube(") == 0 && cmd.slice(-1) == ")") {
        local argsString = cmd.slice(11, -1);
        local args = argsString.split(",");

        // Basic parsing - assumes arguments are simple strings or numbers
        local type = null;
        local data = null;
        local pos = null;

        if (args.len() > 0) {
          local typeStr = args[0].strip();
          // Attempt to parse type as integer (for enums) or string
          if (typeStr.tointeger().tostring() == typeStr && typeStr.len() > 0) {
            type = typeStr.tointeger(); // Parses integer literals
          } else if (typeStr.len() > 1 && typeStr[0] == '"') {
             // Handle quoted strings like "TEXT", "MODIFIER", or "H1"
             type = typeStr.slice(1, -1);
          } else {
             // Assume it's a global variable name (like H1)
             // This requires the variable to be in the global scope
             local globalValue = getroottable()[typeStr];
             if (typeof globalValue == "integer") {
                 type = globalValue; // Use the integer value if it's a global integer
             } else {
                 // If not found in globals or not an integer, treat as a raw string type
                 type = typeStr;
             }
          }
        }

        if (args.len() > 1) {
          local dataStr = args[1].strip();
           if (dataStr.len() > 1 && dataStr[0] == '"') {
             // Handle quoted string data
             data = dataStr.slice(1, -1);
           } else if (dataStr == "null") {
             data = null;
           } else {
             // Attempt to parse as number or boolean if not a string literal
             if (dataStr.tointeger().tostring() == dataStr) data = dataStr.tointeger();
             else if (dataStr.tofloat().tostring() == dataStr) data = dataStr.tofloat();
             else if (dataStr == "true") data = true;
             else if (dataStr == "false") data = false;
             else data = dataStr; // Fallback to string if parsing fails
           }
        }

        if (args.len() > 2) {
          local posStr = args[2].strip();
          // Basic Vector parsing - assumes format Vector(x, y, z)
          if (posStr.find("Vector(") == 0 && posStr.slice(-1) == ")") {
              local coordsStr = posStr.slice(7, -1);
              local coords = coordsStr.split(",");
              if (coords.len() == 3) {
                  local x = coords[0].strip().tofloat();
                  local y = coords[1].strip().tofloat();
                  local z = coords[2].strip().tofloat();
                  pos = Vector(x, y, z);
              } else {
                   throw "Invalid Vector format: " + posStr;
              }
          } else {
              // Handle invalid position format
              throw "Invalid position format: " + posStr;
          }
        }

        ::createCube(type, data, pos);

      } else if (cmd == "newElement") {
        // Keep existing newElement handler for simplicity
        newElement(H1);
      } else if (cmd == "newModifier") {
        // Keep existing newModifier handler for simplicity
        newModifier("style", "color: red");
      } else if (cmd.find("newElement(") == 0) {
        // Keep existing newElement(...) parsing for compatibility
        local content = cmd.slice(11, -1);
        if (content[0] == '"') {
          // Handle text nodes
          local text = content.slice(1, -1);
          newElement(text);
        } else if (content[0] == '-') {
          // Handle closing tags
          local tag = content.slice(1);
          // Note: This still hardcodes to H1, need to add proper parsing
          newElement(-H1); // For now, hardcoded to H1
        } else {
          // Handle opening tags
          // Note: This still hardcodes to H1, need to add proper parsing
          newElement(H1); // For now, hardcoded to H1
        }
      } else {
        // Show error message for unknown commands
        local errorText = ppmod.text("Unknown command: " + cmd, -1, 0.3);
        errorText.SetColor("255 0 0");
        errorText.SetSize(2);
        errorText.Display(2);
      }
    } catch (e) {
      // Show error message
      local errorText = ppmod.text("Error executing command: " + cmd + ". Error: " + e, -1, 0.3);
      errorText.SetColor("255 0 0");
      errorText.SetSize(2);
      errorText.Display(2);
    }
  };
});
