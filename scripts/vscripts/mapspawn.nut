if (!("Entities" in this)) return;

// https://github.com/p2r3/ppmod
IncludeScript("ppmod");
// https://github.com/p2r3/savelock
IncludeScript("sl_httportal");

// Import DOM enums and colors
IncludeScript("domtypes");

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

/**
 * Creates a cube representing an HTML tag or plain text.
 * @param {string|number} type - The type of the element, either a string or a DOM enum.
 * @param {Vector|null} pos - The position to spawn the cube at, or null to spawn at the player's feet.
 * @returns {ppromise<void>} A promise that resolves when the cube is spawned.
 */
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

/**
 * Creates a modifier cube with the given name and data.
 * @param {string} name - The name of the modifier.
 * @param {string} data - The data associated with the modifier.
 * @param {Vector|null} pos - The position to spawn the cube at, or null to spawn at the player's feet.
 * @returns {ppromise<void>} A promise that resolves when the cube is spawned.
 */
::newModifier <- async(function (name, data, pos = null) {

  // Spawn a storage cube at the player's feet
  yield ppmod.give({ prop_weighted_cube = 1 });
  local cube = yielded.prop_weighted_cube[0];

  // Spawn a storage cube, get its handle
  yield spawnHeldCube(pos);
  local cube = yielded;

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

  /**
   * Holds the structure of the HTML document, for serializing later.
   * Honestly, this has very little to do with the actual HTML DOM,
   * but we do need to have iterable and sortable objects.
   */
  local dom = [];

  // We're detaching on almost every step to avoid SQQuerySuspend on big pages
  ppmod.detach(function (args):(dom) {
    // Iterate over all non-modifier cubes and push them into the DOM
    while (args.cube = Entities.FindByClassname(args.cube, "prop_weighted_cube")) {

      local scope = args.cube.GetScriptScope();
      if (!("_domType" in scope)) continue;

      dom.push({
        pos = args.cube.GetOrigin(),
        type = scope._domType,
        modifiers = {}
      });

    }
  }, { cube = null });

  ppmod.detach(function (args):(dom) {
    // Iterate over all modifier cubes and push them onto their respective elements
    while (args.cube = Entities.FindByClassname(args.cube, "prop_weighted_cube")) {

      local scope = args.cube.GetScriptScope();
      if (!("_domModifier" in scope)) continue;

      local pos = args.cube.GetOrigin();

      foreach (obj in dom) {
        // Target cubes below us and within 18 units in X and Y
        // 18 units is the width of a regular storage cube
        if (fabs(obj.pos.x - pos.x) > 18.0) continue;
        if (fabs(obj.pos.y - pos.y) > 18.0) continue;
        // Set the modifier string, or append to it if it already exists
        if (!(scope._domModifier in obj.modifiers)) {
          obj.modifiers[scope._domModifier] <- scope._domData;
        } else {
          obj.modifiers[scope._domModifier] += ";" + scope._domData;
        }
      }

    }
  }, { cube = null });

  // Sort the DOM elements, first by Y position, then by X position
  // This mimics the way HTML elements are rendered in a document
  dom.sort(function (a, b) {
    // The Y position has an 18 unit tolerance, to allow for human error
    // when manually placing cubes in the world
    if (a.pos.y > b.pos.y + 18.0) return -1;
    if (a.pos.y < b.pos.y - 18.0) return 1;
    if (a.pos.x > b.pos.x) return 1;
    if (a.pos.x < b.pos.x) return -1;
    return 0;
  });

  // Silly object reference hack, Squirrel doesn't have closures
  local ref = { output = "" };

  ppmod.detach(function (args):(dom, ref) {
    while (args.i < dom.len()) {
      local obj = dom[args.i];

      // Build the modifiers string from the object's modifiers
      local modifiers = "";
      foreach (key, value in obj.modifiers) {
        modifiers += key + "=\"" + value + "\" ";
      }

      // Write the object itself to the output string
      if (typeof obj.type == "string") {
        ref.output += obj.type;
      } else {
        ref.output += "<" + (obj.type < 0 ? "/" : "") + DOM_ELEMENTS[abs(obj.type)] + " " + modifiers + ">";
      }

      args.i ++;
    }
  }, { i = 0 });

  return ref.output;

};

// Sends the generated HTML document to the client
::sendHTTP <- function (document) {

  // Convert to ppstring for couting newlines
  local str = ppstring(document);

  printl("HTTP/1.1 200 OK");
  printl("Server: Portal 2");
  printl("Content-Type: text/html");
  printl("Content-Length: " + (str.len() + str.split("\n").len()));
  printl("");

  // It seems like the console has some limit on how much it can print at once,
  // so we split the output into chunks of 1024 characters.
  for (local i = 0; i <= str.len() / 1024; i ++) {
    print(str.slice(i * 1024, min(i * 1024 + 1024, str.len())));
  }

  // Double newline, just in case
  printl("");
  printl("");

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

});
