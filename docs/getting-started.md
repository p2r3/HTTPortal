# Getting Started with HTTPortal

*Last updated: May 26, 2025*

This guide will help you get HTTPortal up and running in Portal 2.

## Prerequisites

- Portal 2 installed on Steam
- Basic knowledge of HTML
- Developer console enabled in Portal 2

## Installation

1. **Configure Portal 2**
   - Open Steam
   - Right-click on Portal 2
   - Select "Properties"
   - In the "Launch Options" field, add: `-netconport 3000`
   - Click "OK"

2. **Install the Mod**
   - Clone this repository or download the latest release
   - Move the contents to your Portal 2 directory
   - Rename the folder to `portal2_dlcX` (where X is the lowest unused number)
   - The path should look like: `Steam/steamapps/common/Portal 2/portal2_dlcX/`

3. **Verify Installation**
   - Start Portal 2
   - You should be automatically taken to the Laser Chaining level
   - Open `localhost:3000` in your web browser
   - You should see a blank page

## Basic Setup

1. **Enable Developer Console**
   - Open Portal 2's keyboard settings
   - Find "Toggle Developer Console"
   - Assign a key (usually `~` or `` ` ``)
   - Save settings

2. **Test the Setup**
   - Open the developer console in-game
   - Type: `script createCube(H1, null)`
   - You should see a red cube appear at your feet
   - Type: `GET` in the console
   - Refresh your browser
   - You should see `<h1></h1>` in the page

## First Steps

1. **Create a Simple Page**
   ```squirrel
   // Create a heading
   script createCube(H1, null)
   script createCube("TEXT", "Hello, World!")
   script createCube(-H1, null)

   // Create a paragraph
   script createCube(P, null)
   script createCube("TEXT", "Welcome to HTTPortal!")
   script createCube(-P, null)
   ```

2. **Add Some Style**
   ```squirrel
   // Add color to the heading
   script createCube("MODIFIER", "style: color: red")
   ```

3. **View Your Page**
   - Type `GET` in the console
   - Refresh your browser
   - You should see your styled heading and paragraph

## Next Steps

- Read the [Core Concepts](./core-concepts.md) guide to understand how HTTPortal works
- Check out the [Building Web Pages](./building-pages.md) guide for more examples
- Explore the [Command Reference](./commands.md) for all available commands

## Common Issues

If you encounter any problems:
1. Make sure Portal 2 is running with the `-netconport 3000` launch option
2. Verify the mod files are in the correct location
3. Check that the developer console is enabled
4. See the [Troubleshooting](./troubleshooting.md) guide for more help 