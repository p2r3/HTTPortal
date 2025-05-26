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
    printl("Unrecognized element type!");
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
};

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
    if (cmd == "newElement") {
      newElement(H1);
    } else if (cmd == "newModifier") {
      newModifier("style", "color: red");
    } else {
      printl("Unknown command: " + cmd);
    }
  };

});
