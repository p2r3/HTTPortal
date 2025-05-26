/**
 * Portal 2 Save Lock System
 * =======================
 * This script ensures mod functionality persists after loading saves by detecting
 * file structure changes and reloading the level if necessary.
 * 
 * Features:
 * - Automatic level reload on save load if mod files are missing
 * - Save state validation
 * - Mod integrity checking
 * - Graceful error handling
 * 
 * @author p2r3
 * @version 2.1
 * @updated by Green_Detek
 */

// Prevent recursive script inclusion
if (getstackinfos(4) && getstackinfos(4).src == getstackinfos(1).src) {
    printl("[SaveLock] Prevented recursive script inclusion");
    return;
}

// Ensure we're running on the server's script scope
if (!("Entities" in this)) {
    printl("[SaveLock] Script must run on server scope");
    return;
}

// Constants
const REQUIRED_SCRIPTS = [
    "ppmod",
    "domtypes",
    "mapspawn"
];

const SAVE_CHECK_DELAY = 0.1;  // Delay in seconds before checking save state
const MAX_RETRIES = 3;         // Maximum number of retries for script inclusion

/**
 * Utility Functions
 * ================
 */

/**
 * Checks if all required scripts are present
 * @return True if all required scripts are present
 */
function ValidateRequiredScripts() {
    foreach (script in REQUIRED_SCRIPTS) {
        try {
            IncludeScript(script);
        } catch (e) {
            printl("[SaveLock] Missing required script: " + script);
            return false;
        }
    }
    return true;
}

/**
 * Displays a message to the player about save state
 * @param message The message to display
 */
function DisplaySaveMessage(message) {
    local text = ppmod.text(message, -1, 0.3);
    text.SetColor("255 255 0");  // Yellow color for save-related messages
    text.SetSize(2);
    text.Display(3.0);
}

/**
 * Core Functions
 * =============
 */

/**
 * Initializes the save lock system
 * Called once when entity I/O has initialized
 */
::__slInit <- function () {
    printl("[SaveLock] Initializing save lock system...");
    
    // Find or create logic_auto entity
    local auto = null;
    while (auto = Entities.FindByClassname(null, "logic_auto")) {
        if (!auto.IsValid()) continue;
        if (auto.GetName() == "") break;
    }
    
    if (!auto) {
        printl("[SaveLock] Creating logic_auto entity");
        auto = Entities.CreateByClassname("logic_auto");
    }
    
    // Connect to OnLoadGame output
    auto.ConnectOutput("OnLoadGame", "__slLoad");
    
    // Initial validation of required scripts
    if (!ValidateRequiredScripts()) {
        printl("[SaveLock] Warning: Some required scripts are missing on initial load");
        DisplaySaveMessage("Warning: Some mod components are missing");
    }
};

/**
 * Handles save game loading
 * Called after the map has finished loading, on every load
 */
::__slLoad <- function () {
    printl("[SaveLock] Save game loaded, validating mod state...");
    
    local retryCount = 0;
    local success = false;
    
    // Try to include the script with retries
    while (retryCount < MAX_RETRIES && !success) {
        try {
            IncludeScript(getstackinfos(1).src);
            success = true;
        } catch (e) {
            retryCount++;
            if (retryCount < MAX_RETRIES) {
                printl("[SaveLock] Retry " + retryCount + " of " + MAX_RETRIES);
                ppmod.wait(null, SAVE_CHECK_DELAY);
            }
        }
    }
    
    if (!success) {
        printl("[SaveLock] Failed to validate mod state after " + MAX_RETRIES + " attempts");
        DisplaySaveMessage("Mod files missing - reloading level...");
        SendToConsole("restart_level");
        return;
    }
    
    // Validate all required scripts
    if (!ValidateRequiredScripts()) {
        printl("[SaveLock] Required scripts missing after save load");
        DisplaySaveMessage("Mod components missing - reloading level...");
        SendToConsole("restart_level");
        return;
    }
    
    printl("[SaveLock] Mod state validated successfully");
    DisplaySaveMessage("Mod state validated");
};

// Initialize the save lock system
EntFireByHandle(Entities.First(), "RunScriptCode", "::__slInit()", 0.0, null, null);
