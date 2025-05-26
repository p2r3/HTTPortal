# Frequently Asked Questions

*Last updated: May 26, 2025*

This guide answers common questions about HTTPortal.

## General Questions

### What is HTTPortal?
HTTPortal is a Portal 2 mod that turns the game into a basic HTTP/1.1 server. It allows you to create web pages using colored cubes in the game world.

### How does it work?
HTTPortal uses colored cubes to represent HTML elements, with their positions determining the structure of the resulting web page. When you type `GET` in the console, it scans the level, converts the cubes to HTML, and serves the page on localhost:3000.

### What do I need to use HTTPortal?
- Portal 2 installed on Steam
- Basic knowledge of HTML
- Developer console enabled
- The mod files installed correctly

## Technical Questions

### How do I install HTTPortal?
1. Add `-netconport 3000` to Portal 2's launch options
2. Install the mod files in your Portal 2 directory
3. Start Portal 2 and load the Laser Chaining level

### Why aren't my cubes appearing?
- Make sure you're in the correct level
- Check cube spawning permissions
- Verify there's enough space
- Try reloading the mod

### How do I add styles to elements?
Place a dark grey modifier cube near the element with the text `style: property: value`. Multiple properties can be added with multiple cubes.

### Why is my page not showing up?
- Check if the server is running
- Verify cube positions
- Ensure proper element nesting
- Check for missing closing tags

## Performance Questions

### How many cubes can I use?
There's no strict limit, but for best performance:
- Keep the number reasonable
- Use efficient layouts
- Avoid unnecessary modifiers
- Consider splitting large pages

### Why is the server slow?
- Too many cubes
- Complex styles
- Large pages
- Resource limits

### How do I optimize my pages?
- Minimize cube count
- Use efficient layouts
- Avoid unnecessary modifiers
- Split large pages
- Cache responses

## Save Questions

### How do I save my pages?
Use the `SAVE_PAGE` command followed by a name:
```
SAVE_PAGE my_page
```

### Why isn't my save working?
- Check file permissions
- Verify save location
- Ensure mod is loaded
- Try manual save

### How do I load a saved page?
Use the `LOAD_PAGE` command:
```
LOAD_PAGE my_page
```

## Style Questions

### How do I add colors?
Use the `style: color` modifier:
```
style: color: red
style: color: #FF0000
style: color: rgb(255, 0, 0)
```

### How do I position elements?
- Use the grid for alignment
- Keep 18 units spacing
- Place left-to-right, top-to-bottom
- Use the level's grid

### How do I create layouts?
- Use div containers
- Add flexbox styles
- Use grid alignment
- Position elements carefully

## Server Questions

### How do I start the server?
The server starts automatically when you load the level. You can also use:
```
START_SERVER [port]
```

### Why can't I connect?
- Check if server is running
- Verify port availability
- Check firewall settings
- Try different port

### How do I check server status?
Use the `SERVER_STATUS` command to see server information.

## Development Questions

### How do I contribute?
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

### Where do I report bugs?
- Create an issue on GitHub
- Include steps to reproduce
- Add screenshots if possible
- Provide error messages

### How do I test changes?
- Create a test map
- Use debug commands
- Check console output
- Verify functionality

## Next Steps

- Read the [Getting Started](./getting-started.md) guide
- Check the [Core Concepts](./core-concepts.md) guide
- See the [Command Reference](./commands.md)
- Read the [Technical Reference](./technical.md)
- Check [Troubleshooting](./troubleshooting.md) for help 