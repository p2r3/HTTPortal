/**
 * Reloads the current level if this file is missing after a save load.
 *
 * Players often believe that mods "didn't uninstall" when they have in
 * fact just loaded a save from the menu, which persists script scope.
 * This tool aims to solve that by detecting a file structure change.
 *
 * @author p2r3
 */

// Exit early if this file has called itself
if (getstackinfos(4) && getstackinfos(4).src == getstackinfos(1).src) return;

// Ensure we're running on the server's script scope
if (!("Entities" in this)) return;

// The entrypoint function - called once entity I/O has initialized
::__slInit <- function () {
  /**
   * Look for an unnamed "logic_auto" entity for connecting functions to
   * run on load. If such an entity is not found, one is created. In this
   * case, entity indexes may be offset. If that is a concern, savelock
   * should be loaded after code that reads entindex.
   */
  local auto = null;
  while (auto = Entities.FindByClassname(null, "logic_auto")) {
    if (!auto.IsValid()) continue;
    if (auto.GetName() == "") break;
  }
  if (!auto) auto = Entities.CreateByClassname("logic_auto");
  auto.ConnectOutput("OnLoadGame", "__slLoad");
};

// Called after the map has finished loading, on every load
::__slLoad <- function () {
  try {
    // Try to include this very same script file
    IncludeScript(getstackinfos(1).src);
  } catch (e) {
    // If it no longer exists, restart the level
    SendToConsole("restart_level");
  }
};

// Run the entrypoint function as soon as entity I/O starts
EntFireByHandle(Entities.First(), "RunScriptCode", "::__slInit()", 0.0, null, null);
