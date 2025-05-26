# HTTPortal
Basic HTTP/1.1 server implementation in Portal 2. [See here](https://youtu.be/-v5vCLLsqbA) for a mid-level overview of the project.

## Usage
- In Steam, add this launch option to Portal 2: `-netconport 3000`
- Clone this repository and move its root directory to your game files. Rename it to `portal2_dlcX`, where X is the lowest positive integer not in use.
- Start Portal 2, you should be brought to Laser Chaining after a couple of loading screens.
- Enable the developer console in keyboard settings (if you haven't already).
- Open `localhost:3000` in a browser - a blank page should open.

### Creating a webpage
Here's a very quick crash course on how to use the page builder:
- To create any part of the webpage structure (elements, text nodes, or modifiers), use the `script createCube(...)` command.
  - The first argument is the **type** of the cube. This can be:
    - An HTML element tag name as a global variable (e.g., `H1`, `DIV`), or its integer value (e.g., `38` for H1).
    - The string `\"TEXT\"` for a text node.
    - The string `\"MODIFIER\"` for a modifier.
  - The second argument is the **data** associated with the cube (optional).
    - For `\"TEXT\"` type, this is the text content (a string).
    - For `\"MODIFIER\"` type, this is a string in the format `\"name: value\"` (e.g., `\"style: color: red\"`).
    - For HTML element types, this is currently unused (pass `null`).
  - The third argument is the **position** of the cube as a `Vector(x, y, z)` (optional, defaults to player's feet if omitted or `null`).

  Here are some examples:
  - To create an HTML element opening tag (e.g., \<H1\>):
    `script createCube(H1, null, Vector(0, 0, 0))`
    `script createCube(\"H1\", null, Vector(0, 0, 0))` // Using string name is also supported
    `script createCube(38, null, Vector(0, 0, 0))` // Using integer value
  - To create an HTML element closing tag (e.g., \</H1\>):
    `script createCube(-H1, null, Vector(50, 0, 0))`
    `script createCube(-\"H1\", null, Vector(50, 0, 0))`
    `script createCube(-38, null, Vector(50, 0, 0))`
  - To create a plaintext node:
    `script createCube(\"TEXT\", \"Hello, World!\", Vector(100, 0, 0))`
  - To create a modifier (e.g., style):
    `script createCube(\"MODIFIER\", \"style: color: red\", Vector(150, 0, 0))`

Elements are ordered first towards -Y, then towards +X. In other words, if you're building your site on Laser Chaining, keep the faith plate platform to your right and place cubes left-to-right, top-to-bottom.

The tag name must be provided as either an unquoted global variable name (recommended), a quoted string matching the global name, or the integer enumeration value. For closing tags, prefix the type with a minus (`-`).

Modifiers _stack_ - both literally and also in the document. So using two `style` modifiers on top of each other will stack the properties, but using two `src` or `href` modifiers will probably just break your link.

## Contributing
Submit issues before pull requests (discuss, then code), and adhere to the code style. Ideally, use the [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) naming scheme. Code that doesn't respect the style/conventions of the code base will not be accepted.
