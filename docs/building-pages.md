# Building Web Pages

This guide explains how to build web pages using HTTPortal's cube-based system.

## Basic Page Structure

### HTML Document

A basic HTML document in HTTPortal looks like this:

```
<!DOCTYPE html>
<html>
  <head>
    <title>My Page</title>
  </head>
  <body>
    <h1>Welcome</h1>
    <p>This is my page.</p>
  </body>
</html>
```

To create this in Portal 2:

1. Place cubes in this order (left to right, top to bottom):
   - DOCTYPE cube
   - HTML opening cube
   - HEAD opening cube
   - TITLE opening cube
   - Text cube with "My Page"
   - TITLE closing cube
   - HEAD closing cube
   - BODY opening cube
   - H1 opening cube
   - Text cube with "Welcome"
   - H1 closing cube
   - P opening cube
   - Text cube with "This is my page."
   - P closing cube
   - BODY closing cube
   - HTML closing cube

### Adding Styles

To add styles to elements:

1. Place a dark grey modifier cube near the element
2. Set its text to: `style: property: value`
3. Multiple properties can be added with multiple cubes

Example:
```
style: color: red
style: font-size: 24px
style: text-align: center
```

## Common Elements

### Headers

1. **H1-H6**
   - Use red cubes (darker for higher numbers)
   - Place text cube after opening tag
   - Add closing tag after text

2. **Paragraphs**
   - Use medium purple cube
   - Can contain multiple text nodes
   - Add modifiers for styling

### Links

1. **Basic Link**
   - Use primary blue cube
   - Add `href` modifier: `href: https://example.com`
   - Place text between tags

2. **Styled Link**
   - Add style modifiers:
     ```
     style: color: blue
     style: text-decoration: underline
     ```

### Images

1. **Basic Image**
   - Use cyan cube
   - Add `src` modifier: `src: https://example.com/image.jpg`
   - Add `alt` modifier for accessibility

2. **Styled Image**
   - Add style modifiers:
     ```
     style: width: 300px
     style: height: auto
     style: border-radius: 5px
     ```

## Layout Techniques

### Div Containers

1. **Basic Container**
   - Use soft blue cube
   - Place elements inside
   - Add closing tag after content

2. **Styled Container**
   - Add style modifiers:
     ```
     style: padding: 20px
     style: margin: 10px
     style: background-color: #f0f0f0
     ```

### Flexbox Layout

1. **Flex Container**
   - Add style modifiers:
     ```
     style: display: flex
     style: flex-direction: row
     style: justify-content: space-between
     ```

2. **Flex Items**
   - Add style modifiers:
     ```
     style: flex: 1
     style: margin: 10px
     ```

## Advanced Features

### Forms

1. **Form Container**
   - Use form cube
   - Add `action` and `method` modifiers

2. **Input Fields**
   - Use input cube
   - Add type modifier: `type: text`
   - Add name modifier: `name: username`

### Tables

1. **Table Structure**
   - Use table cube
   - Add tr cubes for rows
   - Add td cubes for cells

2. **Styled Table**
   - Add style modifiers:
     ```
     style: border-collapse: collapse
     style: width: 100%
     ```

## Best Practices

### Organization

1. **Planning**
   - Sketch your layout first
   - Plan cube placement
   - Consider spacing

2. **Structure**
   - Keep related elements together
   - Use consistent spacing
   - Label sections with comments

### Performance

1. **Optimization**
   - Minimize number of cubes
   - Use efficient layouts
   - Avoid unnecessary modifiers

2. **Maintenance**
   - Keep code organized
   - Document complex structures
   - Use consistent naming

## Troubleshooting

### Common Issues

1. **Elements Not Showing**
   - Check cube order
   - Verify closing tags
   - Check spacing

2. **Styles Not Applying**
   - Verify modifier placement
   - Check syntax
   - Ensure proper spacing

3. **Layout Problems**
   - Check cube positioning
   - Verify flex properties
   - Check container structure

## Next Steps

- Check the [Command Reference](./commands.md)
- Read about [Technical Details](./technical.md)
- See [Troubleshooting](./troubleshooting.md) for help
- Learn about [Contributing](./contributing.md) 