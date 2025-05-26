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
- To create an HTML element (e.g. \<H1\>), use this command: `script newElement(H1)`
- To create a closing tag (e.g. \</H1\>), use this command: `script newElement(-H1)`
- To create a plaintext node, use this command: `script newElement("Hello, World!")`
- To create a modifier (e.g. style), use this command: `script newModifier("style", "color: red")`

Elements are ordered first towards -Y, then towards +X. In other words, if you're building your site on Laser Chaining, keep the faith plate platform to your right and place cubes left-to-right, top-to-bottom.

The tag name must be provided in uppercase, _unquoted_ (it's an enumeration). For closing tags, just append a minus (`-`) to the tag name.

Modifiers _stack_ - both literally and also in the document. So using two `style` modifiers on top of each other will stack the properties, but using two `src` or `href` modifiers will probably just break your link.

## Contributing
Submit issues before pull requests (discuss, then code), and adhere to the code style. Ideally, use the [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) naming scheme. Code that doesn't respect the style/conventions of the code base will not be accepted.
