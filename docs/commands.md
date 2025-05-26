# Command Reference

*Last updated: May 26, 2025*

This guide lists all available commands in HTTPortal and how to use them.

## Console Commands

### Basic Commands

1. **GET**
   - Purpose: Generate and serve the current page
   - Usage: `GET`
   - Description: Scans the level for cubes and serves the resulting HTML
   - Example: `GET`

2. **RELOAD**
   - Purpose: Reload the mod scripts
   - Usage: `RELOAD`
   - Description: Forces a reload of all mod scripts
   - Example: `RELOAD`

3. **CLEAR**
   - Purpose: Clear the console
   - Usage: `CLEAR`
   - Description: Removes all messages from the console
   - Example: `CLEAR`

### Debug Commands

1. **DEBUG**
   - Purpose: Toggle debug mode
   - Usage: `DEBUG [on|off]`
   - Description: Enables/disables debug output
   - Example: `DEBUG on`

2. **SHOW_CUBES**
   - Purpose: Show cube information
   - Usage: `SHOW_CUBES [type]`
   - Description: Displays information about cubes in the level
   - Example: `SHOW_CUBES all`

3. **VALIDATE**
   - Purpose: Validate page structure
   - Usage: `VALIDATE`
   - Description: Checks the current page for errors
   - Example: `VALIDATE`

## Cube Commands

### Element Creation

1. **CREATE_ELEMENT**
   - Purpose: Create a new element cube
   - Usage: `CREATE_ELEMENT <type>`
   - Description: Spawns a new element cube of specified type
   - Example: `CREATE_ELEMENT div`

2. **CREATE_TEXT**
   - Purpose: Create a text node cube
   - Usage: `CREATE_TEXT <content>`
   - Description: Spawns a new text node cube
   - Example: `CREATE_TEXT Hello World`

3. **CREATE_MODIFIER**
   - Purpose: Create a modifier cube
   - Usage: `CREATE_MODIFIER <name> <value>`
   - Description: Spawns a new modifier cube
   - Example: `CREATE_MODIFIER style color: red`

### Element Management

1. **DELETE_CUBE**
   - Purpose: Delete a cube
   - Usage: `DELETE_CUBE <id>`
   - Description: Removes a cube from the level
   - Example: `DELETE_CUBE 123`

2. **MOVE_CUBE**
   - Purpose: Move a cube
   - Usage: `MOVE_CUBE <id> <x> <y> <z>`
   - Description: Moves a cube to specified coordinates
   - Example: `MOVE_CUBE 123 100 0 0`

3. **COPY_CUBE**
   - Purpose: Copy a cube
   - Usage: `COPY_CUBE <id>`
   - Description: Creates a copy of a cube
   - Example: `COPY_CUBE 123`

## Style Commands

### Style Management

1. **ADD_STYLE**
   - Purpose: Add a style modifier
   - Usage: `ADD_STYLE <element_id> <property> <value>`
   - Description: Adds a style modifier to an element
   - Example: `ADD_STYLE 123 color red`

2. **REMOVE_STYLE**
   - Purpose: Remove a style modifier
   - Usage: `REMOVE_STYLE <element_id> <property>`
   - Description: Removes a style modifier from an element
   - Example: `REMOVE_STYLE 123 color`

3. **LIST_STYLES**
   - Purpose: List style modifiers
   - Usage: `LIST_STYLES <element_id>`
   - Description: Shows all style modifiers for an element
   - Example: `LIST_STYLES 123`

## Layout Commands

### Positioning

1. **ALIGN**
   - Purpose: Align cubes
   - Usage: `ALIGN <axis> <value>`
   - Description: Aligns selected cubes on specified axis
   - Example: `ALIGN x 100`

2. **DISTRIBUTE**
   - Purpose: Distribute cubes
   - Usage: `DISTRIBUTE <axis> <spacing>`
   - Description: Evenly distributes selected cubes
   - Example: `DISTRIBUTE y 18`

3. **GRID**
   - Purpose: Create a grid
   - Usage: `GRID <rows> <columns> <spacing>`
   - Description: Creates a grid of cubes
   - Example: `GRID 3 3 18`

## Save Commands

### Save Management

1. **SAVE_PAGE**
   - Purpose: Save current page
   - Usage: `SAVE_PAGE <name>`
   - Description: Saves the current page layout
   - Example: `SAVE_PAGE my_page`

2. **LOAD_PAGE**
   - Purpose: Load a saved page
   - Usage: `LOAD_PAGE <name>`
   - Description: Loads a saved page layout
   - Example: `LOAD_PAGE my_page`

3. **LIST_PAGES**
   - Purpose: List saved pages
   - Usage: `LIST_PAGES`
   - Description: Shows all saved pages
   - Example: `LIST_PAGES`

## Server Commands

### Server Management

1. **START_SERVER**
   - Purpose: Start HTTP server
   - Usage: `START_SERVER [port]`
   - Description: Starts the HTTP server
   - Example: `START_SERVER 3000`

2. **STOP_SERVER**
   - Purpose: Stop HTTP server
   - Usage: `STOP_SERVER`
   - Description: Stops the HTTP server
   - Example: `STOP_SERVER`

3. **SERVER_STATUS**
   - Purpose: Check server status
   - Usage: `SERVER_STATUS`
   - Description: Shows server status information
   - Example: `SERVER_STATUS`

## Next Steps

- Read about [Technical Details](./technical.md)
- See [Troubleshooting](./troubleshooting.md) for help
- Learn about [Contributing](./contributing.md)
- Check the [Core Concepts](./core-concepts.md) guide 