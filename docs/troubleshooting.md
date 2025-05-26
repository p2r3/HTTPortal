# Troubleshooting

This guide helps you solve common issues with HTTPortal.

## Common Issues

### Cube Problems

1. **Cubes Not Appearing**
   - Check if you're in the correct level
   - Verify cube spawning permissions
   - Ensure enough space for cubes
   - Try reloading the mod

2. **Wrong Cube Colors**
   - Verify element type
   - Check color mappings
   - Reload domtypes.nut
   - Clear and respawn cubes

3. **Cubes in Wrong Order**
   - Check positioning system
   - Verify Y then X ordering
   - Use grid for alignment
   - Maintain proper spacing

### HTML Generation

1. **Missing Elements**
   - Check cube positions
   - Verify element types
   - Ensure proper nesting
   - Validate structure

2. **Incorrect HTML**
   - Check element order
   - Verify closing tags
   - Validate attributes
   - Test with simple page

3. **Style Issues**
   - Check modifier placement
   - Verify style syntax
   - Ensure proper spacing
   - Test individual styles

### Server Issues

1. **Server Not Starting**
   - Check port availability
   - Verify permissions
   - Check firewall settings
   - Try different port

2. **Connection Problems**
   - Verify server status
   - Check localhost access
   - Test with different browser
   - Clear browser cache

3. **Response Errors**
   - Check HTML generation
   - Verify content type
   - Test with simple page
   - Check error logs

### Save Problems

1. **Save Not Working**
   - Check file permissions
   - Verify save location
   - Ensure mod is loaded
   - Try manual save

2. **Load Failures**
   - Verify save file exists
   - Check file integrity
   - Ensure mod is loaded
   - Try backup save

3. **State Corruption**
   - Clear current state
   - Reload mod
   - Restore from backup
   - Recreate layout

## Error Messages

### Common Errors

1. **"Invalid Element Type"**
   - Check element definition
   - Verify type number
   - Update domtypes.nut
   - Use valid element

2. **"Missing Closing Tag"**
   - Check cube order
   - Verify nesting
   - Add missing tag
   - Validate structure

3. **"Server Already Running"**
   - Stop existing server
   - Check process list
   - Use different port
   - Restart game

### Debug Messages

1. **"Cube Position Invalid"**
   - Check coordinates
   - Verify spacing
   - Use grid alignment
   - Adjust position

2. **"Style Syntax Error"**
   - Check modifier text
   - Verify property:value
   - Fix syntax
   - Test style

3. **"Save File Corrupt"**
   - Use backup
   - Recreate save
   - Check file integrity
   - Update mod

## Performance Issues

### Slow Response

1. **Too Many Cubes**
   - Reduce cube count
   - Optimize layout
   - Use efficient structure
   - Split into pages

2. **Complex Styles**
   - Simplify styles
   - Use CSS classes
   - Reduce modifiers
   - Optimize properties

3. **Large Pages**
   - Split content
   - Use pagination
   - Optimize structure
   - Cache responses

### Memory Problems

1. **High Memory Usage**
   - Reduce cube count
   - Clear unused cubes
   - Optimize structure
   - Restart game

2. **Memory Leaks**
   - Check cube cleanup
   - Verify resource release
   - Monitor usage
   - Update mod

3. **Resource Limits**
   - Reduce complexity
   - Optimize usage
   - Clear resources
   - Restart server

## Recovery Steps

### Automatic Recovery

1. **Script Reload**
   - Wait for auto-reload
   - Check console
   - Verify scripts
   - Test functionality

2. **State Recovery**
   - Let system recover
   - Check state
   - Verify data
   - Test features

3. **Error Correction**
   - Check fixes
   - Verify changes
   - Test system
   - Monitor stability

### Manual Recovery

1. **Save Recovery**
   - Load backup
   - Verify data
   - Test functionality
   - Update save

2. **State Reset**
   - Clear state
   - Reload mod
   - Recreate layout
   - Test system

3. **System Restart**
   - Save work
   - Close game
   - Restart system
   - Reload mod

## Getting Help

### Support Channels

1. **GitHub Issues**
   - Check existing issues
   - Search for solutions
   - Report new issues
   - Follow updates

2. **Community Forums**
   - Search forums
   - Ask questions
   - Share solutions
   - Get help

3. **Documentation**
   - Read guides
   - Check examples
   - Follow tutorials
   - Learn features

### Reporting Issues

1. **Bug Reports**
   - Describe problem
   - Include steps
   - Add screenshots
   - Provide logs

2. **Feature Requests**
   - Explain need
   - Provide examples
   - Suggest solution
   - Check existing

3. **Improvements**
   - Share ideas
   - Provide code
   - Test changes
   - Submit PR

## Next Steps

- Learn about [Contributing](./contributing.md)
- Check the [Core Concepts](./core-concepts.md) guide
- Read the [Building Pages](./building-pages.md) guide
- See the [Command Reference](./commands.md) 