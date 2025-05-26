# Technical Reference

*Last updated: May 26, 2025*

This guide provides technical details about HTTPortal's implementation and architecture.

## Architecture Overview

### Core Components

1. **Cube System**
   - Element cubes represent HTML elements
   - Text cubes contain content
   - Modifier cubes add attributes
   - Position-based ordering system

2. **HTTP Server**
   - Built on Portal 2's engine
   - Handles HTTP/1.1 requests
   - Converts cubes to HTML
   - Serves pages on localhost:3000

3. **Save System**
   - Persists cube layouts
   - Validates mod integrity
   - Handles script reloading
   - Manages state recovery

## File Structure

### Core Files

1. **valve.rc**
   - Main configuration file
   - Loads required scripts
   - Sets up environment
   - Initializes mod

2. **domtypes.nut**
   - Element type definitions
   - Color mappings
   - Helper functions
   - Type validation

3. **mapspawn.nut**
   - Cube spawning logic
   - Position management
   - HTML generation
   - Layout handling

4. **sl_httportal.nut**
   - Save lock system
   - Script validation
   - State management
   - Error recovery

## Technical Details

### Cube System

1. **Element Types**
   ```squirrel
   // Element type constants
   const ELEMENT_TYPES = {
       DOCTYPE = 1,
       HTML = 2,
       HEAD = 3,
       BODY = 4,
       // ... more types
   }
   ```

2. **Color Mappings**
   ```squirrel
   // Color definitions
   const ELEMENT_COLORS = {
       [ELEMENT_TYPES.H1] = Vector(255, 0, 0),
       [ELEMENT_TYPES.P] = Vector(128, 0, 128),
       // ... more colors
   }
   ```

3. **Position System**
   ```squirrel
   // Position constants
   const CUBE_SPACING = 18
   const CHUNK_SIZE = 100
   ```

### HTTP Server

1. **Request Handling**
   ```squirrel
   // Server configuration
   const SERVER_PORT = 3000
   const MAX_CONNECTIONS = 10
   ```

2. **Response Generation**
   ```squirrel
   // Response headers
   const DEFAULT_HEADERS = {
       "Content-Type": "text/html",
       "Server": "HTTPortal/1.0"
   }
   ```

3. **Error Handling**
   ```squirrel
   // Error codes
   const ERROR_CODES = {
       BAD_REQUEST = 400,
       NOT_FOUND = 404,
       SERVER_ERROR = 500
   }
   ```

### Save System

1. **State Management**
   ```squirrel
   // Save constants
   const SAVE_CHECK_DELAY = 1.0
   const MAX_RETRIES = 3
   ```

2. **Script Validation**
   ```squirrel
   // Required scripts
   const REQUIRED_SCRIPTS = [
       "domtypes.nut",
       "mapspawn.nut",
       "sl_httportal.nut"
   ]
   ```

3. **Error Recovery**
   ```squirrel
   // Recovery settings
   const RECOVERY_SETTINGS = {
       AUTO_RELOAD = true,
       VALIDATE_ON_LOAD = true
   }
   ```

## Performance Considerations

### Optimization

1. **Cube Management**
   - Efficient cube spawning
   - Position caching
   - Chunk-based processing
   - Memory management

2. **HTML Generation**
   - String optimization
   - Template caching
   - Batch processing
   - Memory pooling

3. **Server Performance**
   - Connection pooling
   - Response caching
   - Request queuing
   - Resource limits

### Memory Management

1. **Cube Storage**
   - Efficient data structures
   - Memory pooling
   - Garbage collection
   - Resource cleanup

2. **String Handling**
   - String pooling
   - Buffer management
   - Memory limits
   - Cleanup routines

3. **Resource Limits**
   - Maximum cubes
   - Memory usage
   - Connection limits
   - Processing time

## Error Handling

### Error Types

1. **Cube Errors**
   - Invalid positions
   - Missing elements
   - Type mismatches
   - Structure errors

2. **Server Errors**
   - Connection issues
   - Request errors
   - Response failures
   - Resource limits

3. **Save Errors**
   - File corruption
   - Missing scripts
   - State errors
   - Recovery failures

### Recovery Mechanisms

1. **Automatic Recovery**
   - Script reloading
   - State restoration
   - Error correction
   - Data validation

2. **Manual Recovery**
   - Save restoration
   - State reset
   - Error clearing
   - System restart

3. **Error Prevention**
   - Input validation
   - State checking
   - Resource monitoring
   - Error logging

## Next Steps

- See [Troubleshooting](./troubleshooting.md) for help
- Learn about [Contributing](./contributing.md)
- Check the [Core Concepts](./core-concepts.md) guide
- Read the [Building Pages](./building-pages.md) guide 