# Core Concepts

*Last updated: May 26, 2025*

This guide explains the fundamental concepts behind HTTPortal and how it works.

## How HTTPortal Works

HTTPortal is a mod that turns Portal 2 into a basic HTTP/1.1 server. Here's how it works:

1. **Cube Representation**
   - HTML elements are represented by colored cubes
   - Text nodes are represented by grey cubes
   - Modifiers (attributes) are represented by dark grey cubes

2. **Positioning System**
   - Elements are ordered first towards -Y, then towards +X
   - Keep the faith plate platform to your right
   - Place cubes left-to-right, top-to-bottom
   - Use the Laser Chaining level's grid for alignment

3. **HTTP Server**
   - The mod creates a local HTTP server on port 3000
   - When you type `GET` in the console, it:
     1. Scans the level for cubes
     2. Converts them to HTML
     3. Sends the response to your browser

## DOM Elements in Portal 2

### Element Types

1. **HTML Elements**
   - Represented by colored cubes
   - Colors indicate element type
   - Opening tags are positive numbers
   - Closing tags are negative numbers

2. **Text Nodes**
   - Represented by grey cubes
   - Contain the actual text content
   - Placed between opening and closing tags

3. **Modifiers**
   - Represented by dark grey cubes
   - Add attributes to elements
   - Stack both physically and in the document
   - Format: `name: value`

### Element Colors

- Each HTML element type has a unique color
- Colors are chosen for visibility and distinction
- Common elements:
  - H1-H6: Red shades (darker for higher numbers)
  - P: Medium purple
  - DIV: Soft blue
  - A: Primary blue
  - IMG: Cyan
  - etc.

## Cube Positioning System

### Layout Guidelines

1. **Basic Rules**
   - Elements are read from top to bottom
   - Within the same Y level, left to right
   - Keep 18 units spacing between elements
   - Use the level's grid for alignment

2. **Modifier Placement**
   - Place modifiers near their target element
   - Must be within 18 units of the element
   - Multiple modifiers can stack
   - Order matters for style properties

3. **Text Node Placement**
   - Place between opening and closing tags
   - Keep close to the element it belongs to
   - Can be multiple text nodes per element

### Best Practices

1. **Organization**
   - Plan your layout before placing cubes
   - Use the level's grid for alignment
   - Keep related elements together
   - Leave space for future modifications

2. **Modifiers**
   - Group related modifiers together
   - Place style modifiers first
   - Keep modifiers close to their elements
   - Use consistent spacing

3. **Text Content**
   - Keep text nodes close to their elements
   - Use multiple text nodes for long content
   - Maintain consistent spacing
   - Consider readability when placing

## Technical Details

### Save System

- The mod includes a save lock system
- Ensures mod functionality persists after loading saves
- Automatically reloads if mod files are missing
- Validates required scripts on load

### Performance Considerations

- Keep the number of cubes reasonable
- Use efficient layouts
- Avoid unnecessary modifiers
- Consider chunk size for large pages

### Error Handling

- Invalid elements are marked in red
- Error messages appear in the console
- Save system prevents corrupted states
- Automatic recovery for missing files

## Next Steps

- Learn how to [Build Web Pages](./building-pages.md)
- Check the [Command Reference](./commands.md)
- Read about [Technical Details](./technical.md)
- See [Troubleshooting](./troubleshooting.md) for help 