/**********************************************************************************************
*
*   raylib - A simple and easy-to-use library to enjoy videogames programming (www.raylib.com)
*
*   FEATURES:
*       - NO external dependencies, all required libraries included with raylib
*       - Multiplatform: Windows, Linux, FreeBSD, OpenBSD, NetBSD, DragonFly,
*                        MacOS, Haiku, UWP, Android, Raspberry Pi, HTML5.
*       - Written in plain C code (C99) in PascalCase/camelCase notation
*       - Hardware accelerated with OpenGL (1.1, 2.1, 3.3 or ES2 - choose at compile)
*       - Unique OpenGL abstraction layer (usable as standalone module): [rlgl]
*       - Multiple Fonts formats supported (TTF, XNA fonts, AngelCode fonts)
*       - Outstanding texture formats support, including compressed formats (DXT, ETC, ASTC)
*       - Full 3d support for 3d Shapes, Models, Billboards, Heightmaps and more!
*       - Flexible Materials system, supporting classic maps and PBR maps
*       - Animated 3D models supported (skeletal bones animation) (IQM, glTF)
*       - Shaders support, including Model shaders and Postprocessing shaders
*       - Powerful math module for Vector, Matrix and Quaternion operations: [raymath]
*       - Audio loading and playing with streaming support (WAV, OGG, MP3, FLAC, XM, MOD)
*       - VR stereo rendering with configurable HMD device parameters
*       - Bindings to multiple programming languages available!
*
*   NOTES:
*       One default Font is loaded on InitWindow()->LoadFontDefault() [core, text]
*       One default Texture2D is loaded on rlglInit() [rlgl] (OpenGL 3.3 or ES2)
*       One default Shader is loaded on rlglInit()->rlLoadShaderDefault() [rlgl] (OpenGL 3.3 or ES2)
*       One default RenderBatch is loaded on rlglInit()->rlLoadRenderBatch() [rlgl] (OpenGL 3.3 or ES2)
*
*   DEPENDENCIES (included):
*       [core] rglfw (Camilla Löwy - github.com/glfw/glfw) for window/context management and input (PLATFORM_DESKTOP)
*       [rlgl] glad (David Herberth - github.com/Dav1dde/glad) for OpenGL 3.3 extensions loading (PLATFORM_DESKTOP)
*       [raudio] miniaudio (David Reid - github.com/dr-soft/miniaudio) for audio device/context management
*
*   OPTIONAL DEPENDENCIES (included):
*       [core] msf_gif (Miles Fogle) for GIF recording
*       [core] sinfl (Micha Mettke) for DEFLATE decompression algorythm
*       [core] sdefl (Micha Mettke) for DEFLATE compression algorythm
*       [textures] stb_image (Sean Barret) for images loading (BMP, TGA, PNG, JPEG, HDR...)
*       [textures] stb_image_write (Sean Barret) for image writting (BMP, TGA, PNG, JPG)
*       [textures] stb_image_resize (Sean Barret) for image resizing algorithms
*       [textures] stb_perlin (Sean Barret) for Perlin noise image generation
*       [text] stb_truetype (Sean Barret) for ttf fonts loading
*       [text] stb_rect_pack (Sean Barret) for rectangles packing
*       [models] par_shapes (Philip Rideout) for parametric 3d shapes generation
*       [models] tinyobj_loader_c (Syoyo Fujita) for models loading (OBJ, MTL)
*       [models] cgltf (Johannes Kuhlmann) for models loading (glTF)
*       [raudio] dr_wav (David Reid) for WAV audio file loading
*       [raudio] dr_flac (David Reid) for FLAC audio file loading
*       [raudio] dr_mp3 (David Reid) for MP3 audio file loading
*       [raudio] stb_vorbis (Sean Barret) for OGG audio loading
*       [raudio] jar_xm (Joshua Reisenauer) for XM audio module loading
*       [raudio] jar_mod (Joshua Reisenauer) for MOD audio module loading
*
*
*   LICENSE: zlib/libpng
*
*   raylib is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software:
*
*   Copyright (c) 2013-2021 Ramon Santamaria (@raysan5)
*
*   This software is provided "as-is", without any express or implied warranty. In no event
*   will the authors be held liable for any damages arising from the use of this software.
*
*   Permission is granted to anyone to use this software for any purpose, including commercial
*   applications, and to alter it and redistribute it freely, subject to the following restrictions:
*
*     1. The origin of this software must not be misrepresented; you must not claim that you
*     wrote the original software. If you use this software in a product, an acknowledgment
*     in the product documentation would be appreciated but is not required.
*
*     2. Altered source versions must be plainly marked as such, and must not be misrepresented
*     as being the original software.
*
*     3. This notice may not be removed or altered from any source distribution.
*
**********************************************************************************************/

#ifndef RAYLIB_H
#define RAYLIB_H

// Required for: va_list - Only used by TraceLogCallback
#include <stdarg.h>     

#if defined(_WIN32)
    // Microsoft attibutes to tell compiler that symbols are imported/exported from a .dll
    #if defined(BUILD_LIBTYPE_SHARED)
        // We are building raylib as a Win32 shared library (.dll)
        #define RLAPI __declspec(dllexport)     
    #elif defined(USE_LIBTYPE_SHARED)
        // We are using raylib as a Win32 shared library (.dll)
        #define RLAPI __declspec(dllimport)     
    #else
        // We are building or using raylib as a static library
        #define RLAPI   
    #endif
#else
    // We are building or using raylib as a static library (or Linux shared library)
    #define RLAPI       
#endif

//----------------------------------------------------------------------------------
// Some basic Defines
//----------------------------------------------------------------------------------
#ifndef PI
    #define PI 3.14159265358979323846f
#endif

#define DEG2RAD (PI/180.0f)
#define RAD2DEG (180.0f/PI)

// Allow custom memory allocators
#ifndef RL_MALLOC
    #define RL_MALLOC(sz)       malloc(sz)
#endif
#ifndef RL_CALLOC
    #define RL_CALLOC(n,sz)     calloc(n,sz)
#endif
#ifndef RL_REALLOC
    #define RL_REALLOC(ptr,sz)  realloc(ptr,sz)
#endif
#ifndef RL_FREE
    #define RL_FREE(ptr)        free(ptr)
#endif

// NOTE: MSVC C++ compiler does not support compound literals (C99 feature)
// Plain structures in C++ (without constructors) can be initialized from { } initializers.
#if defined(__cplusplus)
    #define CLITERAL(type)      type
#else
    #define CLITERAL(type)      (type)
#endif

// Some Basic Colors
// NOTE: Custom raylib color palette for amazing visuals on WHITE background
// Light Gray
#define LIGHTGRAY  CLITERAL(Color){ 200, 200, 200, 255 }   
// Gray
#define GRAY       CLITERAL(Color){ 130, 130, 130, 255 }   
// Dark Gray
#define DARKGRAY   CLITERAL(Color){ 80, 80, 80, 255 }      
// Yellow
#define YELLOW     CLITERAL(Color){ 253, 249, 0, 255 }     
// Gold
#define GOLD       CLITERAL(Color){ 255, 203, 0, 255 }     
// Orange
#define ORANGE     CLITERAL(Color){ 255, 161, 0, 255 }     
// Pink
#define PINK       CLITERAL(Color){ 255, 109, 194, 255 }   
// Red
#define RED        CLITERAL(Color){ 230, 41, 55, 255 }     
// Maroon
#define MAROON     CLITERAL(Color){ 190, 33, 55, 255 }     
// Green
#define GREEN      CLITERAL(Color){ 0, 228, 48, 255 }      
// Lime
#define LIME       CLITERAL(Color){ 0, 158, 47, 255 }      
// Dark Green
#define DARKGREEN  CLITERAL(Color){ 0, 117, 44, 255 }      
// Sky Blue
#define SKYBLUE    CLITERAL(Color){ 102, 191, 255, 255 }   
// Blue
#define BLUE       CLITERAL(Color){ 0, 121, 241, 255 }     
// Dark Blue
#define DARKBLUE   CLITERAL(Color){ 0, 82, 172, 255 }      
// Purple
#define PURPLE     CLITERAL(Color){ 200, 122, 255, 255 }   
// Violet
#define VIOLET     CLITERAL(Color){ 135, 60, 190, 255 }    
// Dark Purple
#define DARKPURPLE CLITERAL(Color){ 112, 31, 126, 255 }    
// Beige
#define BEIGE      CLITERAL(Color){ 211, 176, 131, 255 }   
// Brown
#define BROWN      CLITERAL(Color){ 127, 106, 79, 255 }    
// Dark Brown
#define DARKBROWN  CLITERAL(Color){ 76, 63, 47, 255 }      
// White
#define WHITE      CLITERAL(Color){ 255, 255, 255, 255 }   
// Black
#define BLACK      CLITERAL(Color){ 0, 0, 0, 255 }         
// Blank (Transparent)
#define BLANK      CLITERAL(Color){ 0, 0, 0, 0 }           
// Magenta
#define MAGENTA    CLITERAL(Color){ 255, 0, 255, 255 }     
// My own White (raylib logo)
#define RAYWHITE   CLITERAL(Color){ 245, 245, 245, 255 }   

// Temporal hacks to avoid breaking old codebases using
// deprecated raylib implementation or definitions
#define FormatText          TextFormat
#define LoadText            LoadFileText
#define GetExtension        GetFileExtension
#define GetImageData        LoadImageColors
#define FILTER_POINT        TEXTURE_FILTER_POINT
#define FILTER_BILINEAR     TEXTURE_FILTER_BILINEAR
#define MAP_DIFFUSE         MATERIAL_MAP_DIFFUSE
#define PIXELFORMAT_UNCOMPRESSED_R8G8B8A8   PIXELFORMAT_PIXELFORMAT_UNCOMPRESSED_R8G8B8A8

//----------------------------------------------------------------------------------
// Structures Definition
//----------------------------------------------------------------------------------
// Boolean type
#if defined(__STDC__) && __STDC_VERSION__ >= 199901L
    #include <stdbool.h>
#elif !defined(__cplusplus) && !defined(bool)
    typedef enum { false, true } bool;
#endif

// Vector2 type
typedef struct Vector2 {
    float x;
    float y;
} Vector2;

// Vector3 type
typedef struct Vector3 {
    float x;
    float y;
    float z;
} Vector3;

// Vector4 type
typedef struct Vector4 {
    float x;
    float y;
    float z;
    float w;
} Vector4;

// Quaternion type, same as Vector4
typedef Vector4 Quaternion;

// Matrix type (OpenGL style 4x4 - right handed, column major)
typedef struct Matrix {
    float m0, m4, m8, m12;
    float m1, m5, m9, m13;
    float m2, m6, m10, m14;
    float m3, m7, m11, m15;
} Matrix;

// Color type, RGBA (32bit)
typedef struct Color {
    unsigned char r;
    unsigned char g;
    unsigned char b;
    unsigned char a;
} Color;

// Rectangle type
typedef struct Rectangle {
    float x;
    float y;
    float width;
    float height;
} Rectangle;

// Image type, bpp always RGBA (32bit)
// NOTE: Data stored in CPU memory (RAM)
typedef struct Image {
    // Image raw data
    void *data;             
    // Image base width
    int width;              
    // Image base height
    int height;             
    // Mipmap levels, 1 by default
    int mipmaps;            
    // Data format (PixelFormat type)
    int format;             
} Image;

// Texture type
// NOTE: Data stored in GPU memory
typedef struct Texture {
    // OpenGL texture id
    unsigned int id;        
    // Texture base width
    int width;              
    // Texture base height
    int height;             
    // Mipmap levels, 1 by default
    int mipmaps;            
    // Data format (PixelFormat type)
    int format;             
} Texture;

// Texture2D type, same as Texture
typedef Texture Texture2D;

// TextureCubemap type, actually, same as Texture
typedef Texture TextureCubemap;

// RenderTexture type, for texture rendering
typedef struct RenderTexture {
    // OpenGL framebuffer object id
    unsigned int id;        
    // Color buffer attachment texture
    Texture texture;        
    // Depth buffer attachment texture
    Texture depth;          
} RenderTexture;

// RenderTexture2D type, same as RenderTexture
typedef RenderTexture RenderTexture2D;

// N-Patch layout info
typedef struct NPatchInfo {
    // Texture source rectangle
    Rectangle source;       
    // Left border offset
    int left;               
    // Top border offset
    int top;                
    // Right border offset
    int right;              
    // Bottom border offset
    int bottom;             
    // Layout of the n-patch: 3x3, 1x3 or 3x1
    int layout;             
} NPatchInfo;

// Font character info
typedef struct CharInfo {
    // Character value (Unicode)
    int value;              
    // Character offset X when drawing
    int offsetX;            
    // Character offset Y when drawing
    int offsetY;            
    // Character advance position X
    int advanceX;           
    // Character image data
    Image image;            
} CharInfo;

// Font type, includes texture and charSet array data
typedef struct Font {
    // Base size (default chars height)
    int baseSize;           
    // Number of characters
    int charsCount;         
    // Padding around the chars
    int charsPadding;       
    // Characters texture atlas
    Texture2D texture;      
    // Characters rectangles in texture
    Rectangle *recs;        
    // Characters info data
    CharInfo *chars;        
} Font;

// SpriteFont type fallback, defaults to Font
#define SpriteFont Font     

// Camera type, defines a camera position/orientation in 3d space
typedef struct Camera3D {
    // Camera position
    Vector3 position;       
    // Camera target it looks-at
    Vector3 target;         
    // Camera up vector (rotation over its axis)
    Vector3 up;             
    // Camera field-of-view apperture in Y (degrees) in perspective, used as near plane width in orthographic
    float fovy;             
    // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
    int projection;         
} Camera3D;

// Camera type fallback, defaults to Camera3D
typedef Camera3D Camera;    

// Camera2D type, defines a 2d camera
typedef struct Camera2D {
    // Camera offset (displacement from target)
    Vector2 offset;         
    // Camera target (rotation and zoom origin)
    Vector2 target;         
    // Camera rotation in degrees
    float rotation;         
    // Camera zoom (scaling), should be 1.0f by default
    float zoom;             
} Camera2D;

// Vertex data definning a mesh
// NOTE: Data stored in CPU memory (and GPU)
typedef struct Mesh {
    // Number of vertices stored in arrays
    int vertexCount;        
    // Number of triangles stored (indexed or not)
    int triangleCount;      

    // Default vertex data
    
    // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    float *vertices;        
    // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    float *texcoords;       
    // Vertex second texture coordinates (useful for lightmaps) (shader-location = 5)
    float *texcoords2;      
    // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    float *normals;         
    // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    float *tangents;        
    // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    unsigned char *colors;  
    // Vertex indices (in case vertex data comes indexed)
    unsigned short *indices;

    // Animation vertex data
    
    // Animated vertex positions (after bones transformations)
    float *animVertices;    
    // Animated normals (after bones transformations)
    float *animNormals;     
    // Vertex bone ids, up to 4 bones influence by vertex (skinning)
    int *boneIds;           
    // Vertex bone weight, up to 4 bones influence by vertex (skinning)
    float *boneWeights;     

    // OpenGL identifiers
    
    // OpenGL Vertex Array Object id
    unsigned int vaoId;     
    // OpenGL Vertex Buffer Objects id (default vertex data)
    unsigned int *vboId;    
} Mesh;

// Shader type (generic)
typedef struct Shader {
    // Shader program id
    unsigned int id;        
    // Shader locations array (MAX_SHADER_LOCATIONS)
    int *locs;              
} Shader;

// Material texture map
typedef struct MaterialMap {
    // Material map texture
    Texture2D texture;      
    // Material map color
    Color color;            
    // Material map value
    float value;            
} MaterialMap;

// Material type (generic)
typedef struct Material {
    // Material shader
    Shader shader;          
    // Material maps array (MAX_MATERIAL_MAPS)
    MaterialMap *maps;      
    // Material generic parameters (if required)
    float params[4];        
} Material;

// Transformation properties
typedef struct Transform {
    // Translation
    Vector3 translation;    
    // Rotation
    Quaternion rotation;    
    // Scale
    Vector3 scale;          
} Transform;

// Bone information
typedef struct BoneInfo {
    // Bone name
    char name[32];          
    // Bone parent
    int parent;             
} BoneInfo;

// Model type
typedef struct Model {
    // Local transform matrix
    Matrix transform;       

    // Number of meshes
    int meshCount;          
    // Number of materials
    int materialCount;      
    // Meshes array
    Mesh *meshes;           
    // Materials array
    Material *materials;    
    // Mesh material number
    int *meshMaterial;      

    // Animation data
    
    // Number of bones
    int boneCount;          
    // Bones information (skeleton)
    BoneInfo *bones;        
    // Bones base transformation (pose)
    Transform *bindPose;    
} Model;

// Model animation
typedef struct ModelAnimation {
    // Number of bones
    int boneCount;          
    // Number of animation frames
    int frameCount;         
    // Bones information (skeleton)
    BoneInfo *bones;        
    // Poses array by frame
    Transform **framePoses; 
} ModelAnimation;

// Ray type (useful for raycast)
typedef struct Ray {
    // Ray position (origin)
    Vector3 position;       
    // Ray direction
    Vector3 direction;      
} Ray;

// Raycast hit information
typedef struct RayHitInfo {
    // Did the ray hit something?
    bool hit;               
    // Distance to nearest hit
    float distance;         
    // Position of nearest hit
    Vector3 position;       
    // Surface normal of hit
    Vector3 normal;         
} RayHitInfo;

// Bounding box type
typedef struct BoundingBox {
    // Minimum vertex box-corner
    Vector3 min;            
    // Maximum vertex box-corner
    Vector3 max;            
} BoundingBox;

// Wave type, defines audio wave data
typedef struct Wave {
    // Total number of samples
    unsigned int sampleCount;       
    // Frequency (samples per second)
    unsigned int sampleRate;        
    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    unsigned int sampleSize;        
    // Number of channels (1-mono, 2-stereo)
    unsigned int channels;          
    // Buffer data pointer
    void *data;                     
} Wave;

typedef struct rAudioBuffer rAudioBuffer;

// Audio stream type
// NOTE: Useful to create custom audio streams not bound to a specific file
typedef struct AudioStream {
    // Pointer to internal data used by the audio system
    rAudioBuffer *buffer;           

    // Frequency (samples per second)
    unsigned int sampleRate;        
    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    unsigned int sampleSize;        
    // Number of channels (1-mono, 2-stereo)
    unsigned int channels;          
} AudioStream;

// Sound source type
typedef struct Sound {
    // Audio stream
    AudioStream stream;             
    // Total number of samples
    unsigned int sampleCount;       
} Sound;

// Music stream type (audio file streaming from memory)
// NOTE: Anything longer than ~10 seconds should be streamed
typedef struct Music {
    // Audio stream
    AudioStream stream;             
    // Total number of samples
    unsigned int sampleCount;       
    // Music looping enable
    bool looping;                   

    // Type of music context (audio filetype)
    int ctxType;                    
    // Audio context data, depends on type
    void *ctxData;                  
} Music;

// Head-Mounted-Display device parameters
typedef struct VrDeviceInfo {
    // Horizontal resolution in pixels
    int hResolution;                
    // Vertical resolution in pixels
    int vResolution;                
    // Horizontal size in meters
    float hScreenSize;              
    // Vertical size in meters
    float vScreenSize;              
    // Screen center in meters
    float vScreenCenter;            
    // Distance between eye and display in meters
    float eyeToScreenDistance;      
    // Lens separation distance in meters
    float lensSeparationDistance;   
    // IPD (distance between pupils) in meters
    float interpupillaryDistance;   
    // Lens distortion constant parameters
    float lensDistortionValues[4];  
    // Chromatic aberration correction parameters
    float chromaAbCorrection[4];    
} VrDeviceInfo;

// VR Stereo rendering configuration for simulator
typedef struct VrStereoConfig {
    // VR projection matrices (per eye)
    Matrix projection[2];           
    // VR view offset matrices (per eye)
    Matrix viewOffset[2];           
    // VR left lens center
    float leftLensCenter[2];        
    // VR right lens center
    float rightLensCenter[2];       
    // VR left screen center
    float leftScreenCenter[2];      
    // VR right screen center
    float rightScreenCenter[2];     
    // VR distortion scale
    float scale[2];                 
    // VR distortion scale in
    float scaleIn[2];               
} VrStereoConfig;

//----------------------------------------------------------------------------------
// Enumerators Definition
//----------------------------------------------------------------------------------
// System/Window config flags
// NOTE: Every bit registers one state (use it with bit masks)
// By default all flags are set to 0
typedef enum {
    // Set to try enabling V-Sync on GPU
    FLAG_VSYNC_HINT         = 0x00000040,   
    // Set to run program in fullscreen
    FLAG_FULLSCREEN_MODE    = 0x00000002,   
    // Set to allow resizable window
    FLAG_WINDOW_RESIZABLE   = 0x00000004,   
    // Set to disable window decoration (frame and buttons)
    FLAG_WINDOW_UNDECORATED = 0x00000008,   
    // Set to hide window
    FLAG_WINDOW_HIDDEN      = 0x00000080,   
    // Set to minimize window (iconify)
    FLAG_WINDOW_MINIMIZED   = 0x00000200,   
    // Set to maximize window (expanded to monitor)
    FLAG_WINDOW_MAXIMIZED   = 0x00000400,   
    // Set to window non focused
    FLAG_WINDOW_UNFOCUSED   = 0x00000800,   
    // Set to window always on top
    FLAG_WINDOW_TOPMOST     = 0x00001000,   
    // Set to allow windows running while minimized
    FLAG_WINDOW_ALWAYS_RUN  = 0x00000100,   
    // Set to allow transparent framebuffer
    FLAG_WINDOW_TRANSPARENT = 0x00000010,   
    // Set to support HighDPI
    FLAG_WINDOW_HIGHDPI     = 0x00002000,   
    // Set to try enabling MSAA 4X
    FLAG_MSAA_4X_HINT       = 0x00000020,   
    // Set to try enabling interlaced video format (for V3D)
    FLAG_INTERLACED_HINT    = 0x00010000    
} ConfigFlags;

// Trace log level
typedef enum {
    // Display all logs
    LOG_ALL = 0,        
    LOG_TRACE,
    LOG_DEBUG,
    LOG_INFO,
    LOG_WARNING,
    LOG_ERROR,
    LOG_FATAL,
    // Disable logging
    LOG_NONE            
} TraceLogLevel;

// Keyboard keys (US keyboard layout)
// NOTE: Use GetKeyPressed() to allow redefining
// required keys for alternative layouts
typedef enum {
    KEY_NULL            = 0,
    // Alphanumeric keys
    
    KEY_APOSTROPHE      = 39,
    KEY_COMMA           = 44,
    KEY_MINUS           = 45,
    KEY_PERIOD          = 46,
    KEY_SLASH           = 47,
    KEY_ZERO            = 48,
    KEY_ONE             = 49,
    KEY_TWO             = 50,
    KEY_THREE           = 51,
    KEY_FOUR            = 52,
    KEY_FIVE            = 53,
    KEY_SIX             = 54,
    KEY_SEVEN           = 55,
    KEY_EIGHT           = 56,
    KEY_NINE            = 57,
    KEY_SEMICOLON       = 59,
    KEY_EQUAL           = 61,
    KEY_A               = 65,
    KEY_B               = 66,
    KEY_C               = 67,
    KEY_D               = 68,
    KEY_E               = 69,
    KEY_F               = 70,
    KEY_G               = 71,
    KEY_H               = 72,
    KEY_I               = 73,
    KEY_J               = 74,
    KEY_K               = 75,
    KEY_L               = 76,
    KEY_M               = 77,
    KEY_N               = 78,
    KEY_O               = 79,
    KEY_P               = 80,
    KEY_Q               = 81,
    KEY_R               = 82,
    KEY_S               = 83,
    KEY_T               = 84,
    KEY_U               = 85,
    KEY_V               = 86,
    KEY_W               = 87,
    KEY_X               = 88,
    KEY_Y               = 89,
    KEY_Z               = 90,

    // Function keys
    
    KEY_SPACE           = 32,
    KEY_ESCAPE          = 256,
    KEY_ENTER           = 257,
    KEY_TAB             = 258,
    KEY_BACKSPACE       = 259,
    KEY_INSERT          = 260,
    KEY_DELETE          = 261,
    KEY_RIGHT           = 262,
    KEY_LEFT            = 263,
    KEY_DOWN            = 264,
    KEY_UP              = 265,
    KEY_PAGE_UP         = 266,
    KEY_PAGE_DOWN       = 267,
    KEY_HOME            = 268,
    KEY_END             = 269,
    KEY_CAPS_LOCK       = 280,
    KEY_SCROLL_LOCK     = 281,
    KEY_NUM_LOCK        = 282,
    KEY_PRINT_SCREEN    = 283,
    KEY_PAUSE           = 284,
    KEY_F1              = 290,
    KEY_F2              = 291,
    KEY_F3              = 292,
    KEY_F4              = 293,
    KEY_F5              = 294,
    KEY_F6              = 295,
    KEY_F7              = 296,
    KEY_F8              = 297,
    KEY_F9              = 298,
    KEY_F10             = 299,
    KEY_F11             = 300,
    KEY_F12             = 301,
    KEY_LEFT_SHIFT      = 340,
    KEY_LEFT_CONTROL    = 341,
    KEY_LEFT_ALT        = 342,
    KEY_LEFT_SUPER      = 343,
    KEY_RIGHT_SHIFT     = 344,
    KEY_RIGHT_CONTROL   = 345,
    KEY_RIGHT_ALT       = 346,
    KEY_RIGHT_SUPER     = 347,
    KEY_KB_MENU         = 348,
    KEY_LEFT_BRACKET    = 91,
    KEY_BACKSLASH       = 92,
    KEY_RIGHT_BRACKET   = 93,
    KEY_GRAVE           = 96,

    // Keypad keys
    
    KEY_KP_0            = 320,
    KEY_KP_1            = 321,
    KEY_KP_2            = 322,
    KEY_KP_3            = 323,
    KEY_KP_4            = 324,
    KEY_KP_5            = 325,
    KEY_KP_6            = 326,
    KEY_KP_7            = 327,
    KEY_KP_8            = 328,
    KEY_KP_9            = 329,
    KEY_KP_DECIMAL      = 330,
    KEY_KP_DIVIDE       = 331,
    KEY_KP_MULTIPLY     = 332,
    KEY_KP_SUBTRACT     = 333,
    KEY_KP_ADD          = 334,
    KEY_KP_ENTER        = 335,
    KEY_KP_EQUAL        = 336,
    // Android key buttons
    
    KEY_BACK            = 4,
    KEY_MENU            = 82,
    KEY_VOLUME_UP       = 24,
    KEY_VOLUME_DOWN     = 25
} KeyboardKey;

// Mouse buttons
typedef enum {
    MOUSE_LEFT_BUTTON   = 0,
    MOUSE_RIGHT_BUTTON  = 1,
    MOUSE_MIDDLE_BUTTON = 2
} MouseButton;

// Mouse cursor
typedef enum {
    MOUSE_CURSOR_DEFAULT       = 0,
    MOUSE_CURSOR_ARROW         = 1,
    MOUSE_CURSOR_IBEAM         = 2,
    MOUSE_CURSOR_CROSSHAIR     = 3,
    MOUSE_CURSOR_POINTING_HAND = 4,
    // The horizontal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_EW     = 5,     
    // The vertical resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NS     = 6,     
    // The top-left to bottom-right diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NWSE   = 7,     
    // The top-right to bottom-left diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NESW   = 8,     
    // The omni-directional resize/move cursor shape
    MOUSE_CURSOR_RESIZE_ALL    = 9,     
    // The operation-not-allowed shape
    MOUSE_CURSOR_NOT_ALLOWED   = 10     
} MouseCursor;

// Gamepad buttons
typedef enum {
    // This is here just for error checking
    
    GAMEPAD_BUTTON_UNKNOWN = 0,

    // This is normally a DPAD
    
    GAMEPAD_BUTTON_LEFT_FACE_UP,
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT,
    GAMEPAD_BUTTON_LEFT_FACE_DOWN,
    GAMEPAD_BUTTON_LEFT_FACE_LEFT,

    // This normally corresponds with PlayStation and Xbox controllers
    
    // XBOX: [Y,X,A,B]
    
    // PS3: [Triangle,Square,Cross,Circle]
    
    // No support for 6 button controllers though..
    
    GAMEPAD_BUTTON_RIGHT_FACE_UP,
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT,
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN,
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT,

    // Triggers
    
    GAMEPAD_BUTTON_LEFT_TRIGGER_1,
    GAMEPAD_BUTTON_LEFT_TRIGGER_2,
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1,
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2,

    // These are buttons in the center of the gamepad
    
    // PS3 Select
    GAMEPAD_BUTTON_MIDDLE_LEFT,     
    // PS Button/XBOX Button
    GAMEPAD_BUTTON_MIDDLE,          
    // PS3 Start
    GAMEPAD_BUTTON_MIDDLE_RIGHT,    

    // These are the joystick press in buttons
    
    GAMEPAD_BUTTON_LEFT_THUMB,
    GAMEPAD_BUTTON_RIGHT_THUMB
} GamepadButton;

// Gamepad axis
typedef enum {
    // Left stick
    
    GAMEPAD_AXIS_LEFT_X = 0,
    GAMEPAD_AXIS_LEFT_Y = 1,

    // Right stick
    
    GAMEPAD_AXIS_RIGHT_X = 2,
    GAMEPAD_AXIS_RIGHT_Y = 3,

    // Pressure levels for the back triggers
    
    // [1..-1] (pressure-level)
    GAMEPAD_AXIS_LEFT_TRIGGER = 4,      
    // [1..-1] (pressure-level)
    GAMEPAD_AXIS_RIGHT_TRIGGER = 5      
} GamepadAxis;

// Material map index
typedef enum {
    // MATERIAL_MAP_DIFFUSE
    MATERIAL_MAP_ALBEDO    = 0,       
    // MATERIAL_MAP_SPECULAR
    MATERIAL_MAP_METALNESS = 1,       
    MATERIAL_MAP_NORMAL    = 2,
    MATERIAL_MAP_ROUGHNESS = 3,
    MATERIAL_MAP_OCCLUSION,
    MATERIAL_MAP_EMISSION,
    MATERIAL_MAP_HEIGHT,
    MATERIAL_MAP_BRDG,
    // NOTE: Uses GL_TEXTURE_CUBE_MAP
    MATERIAL_MAP_CUBEMAP,             
    // NOTE: Uses GL_TEXTURE_CUBE_MAP
    MATERIAL_MAP_IRRADIANCE,          
    // NOTE: Uses GL_TEXTURE_CUBE_MAP
    MATERIAL_MAP_PREFILTER            
} MaterialMapIndex;

#define MATERIAL_MAP_DIFFUSE      MATERIAL_MAP_ALBEDO
#define MATERIAL_MAP_SPECULAR     MATERIAL_MAP_METALNESS

// Shader location index
typedef enum {
    SHADER_LOC_VERTEX_POSITION = 0,
    SHADER_LOC_VERTEX_TEXCOORD01,
    SHADER_LOC_VERTEX_TEXCOORD02,
    SHADER_LOC_VERTEX_NORMAL,
    SHADER_LOC_VERTEX_TANGENT,
    SHADER_LOC_VERTEX_COLOR,
    SHADER_LOC_MATRIX_MVP,
    SHADER_LOC_MATRIX_VIEW,
    SHADER_LOC_MATRIX_PROJECTION,
    SHADER_LOC_MATRIX_MODEL,
    SHADER_LOC_MATRIX_NORMAL,
    SHADER_LOC_VECTOR_VIEW,
    SHADER_LOC_COLOR_DIFFUSE,
    SHADER_LOC_COLOR_SPECULAR,
    SHADER_LOC_COLOR_AMBIENT,
    // SHADER_LOC_MAP_DIFFUSE
    SHADER_LOC_MAP_ALBEDO,          
    // SHADER_LOC_MAP_SPECULAR
    SHADER_LOC_MAP_METALNESS,       
    SHADER_LOC_MAP_NORMAL,
    SHADER_LOC_MAP_ROUGHNESS,
    SHADER_LOC_MAP_OCCLUSION,
    SHADER_LOC_MAP_EMISSION,
    SHADER_LOC_MAP_HEIGHT,
    SHADER_LOC_MAP_CUBEMAP,
    SHADER_LOC_MAP_IRRADIANCE,
    SHADER_LOC_MAP_PREFILTER,
    SHADER_LOC_MAP_BRDF
} ShaderLocationIndex;

#define SHADER_LOC_MAP_DIFFUSE      SHADER_LOC_MAP_ALBEDO
#define SHADER_LOC_MAP_SPECULAR     SHADER_LOC_MAP_METALNESS

// Shader uniform data type
typedef enum {
    SHADER_UNIFORM_FLOAT = 0,
    SHADER_UNIFORM_VEC2,
    SHADER_UNIFORM_VEC3,
    SHADER_UNIFORM_VEC4,
    SHADER_UNIFORM_INT,
    SHADER_UNIFORM_IVEC2,
    SHADER_UNIFORM_IVEC3,
    SHADER_UNIFORM_IVEC4,
    SHADER_UNIFORM_SAMPLER2D
} ShaderUniformDataType;

// Pixel formats
// NOTE: Support depends on OpenGL version and platform
typedef enum {
    // 8 bit per pixel (no alpha)
    PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1,     
    // 8*2 bpp (2 channels)
    PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,        
    // 16 bpp
    PIXELFORMAT_UNCOMPRESSED_R5G6B5,            
    // 24 bpp
    PIXELFORMAT_UNCOMPRESSED_R8G8B8,            
    // 16 bpp (1 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R5G5B5A1,          
    // 16 bpp (4 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R4G4B4A4,          
    // 32 bpp
    PIXELFORMAT_UNCOMPRESSED_R8G8B8A8,          
    // 32 bpp (1 channel - float)
    PIXELFORMAT_UNCOMPRESSED_R32,               
    // 32*3 bpp (3 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32,         
    // 32*4 bpp (4 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32A32,      
    // 4 bpp (no alpha)
    PIXELFORMAT_COMPRESSED_DXT1_RGB,            
    // 4 bpp (1 bit alpha)
    PIXELFORMAT_COMPRESSED_DXT1_RGBA,           
    // 8 bpp
    PIXELFORMAT_COMPRESSED_DXT3_RGBA,           
    // 8 bpp
    PIXELFORMAT_COMPRESSED_DXT5_RGBA,           
    // 4 bpp
    PIXELFORMAT_COMPRESSED_ETC1_RGB,            
    // 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_RGB,            
    // 8 bpp
    PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA,       
    // 4 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGB,            
    // 4 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGBA,           
    // 8 bpp
    PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA,       
    // 2 bpp
    PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA        
} PixelFormat;

// Texture parameters: filter mode
// NOTE 1: Filtering considers mipmaps if available in the texture
// NOTE 2: Filter is accordingly set for minification and magnification
typedef enum {
    // No filter, just pixel aproximation
    TEXTURE_FILTER_POINT = 0,               
    // Linear filtering
    TEXTURE_FILTER_BILINEAR,                
    // Trilinear filtering (linear with mipmaps)
    TEXTURE_FILTER_TRILINEAR,               
    // Anisotropic filtering 4x
    TEXTURE_FILTER_ANISOTROPIC_4X,          
    // Anisotropic filtering 8x
    TEXTURE_FILTER_ANISOTROPIC_8X,          
    // Anisotropic filtering 16x
    TEXTURE_FILTER_ANISOTROPIC_16X,         
} TextureFilter;

// Texture parameters: wrap mode
typedef enum {
    // Repeats texture in tiled mode
    TEXTURE_WRAP_REPEAT = 0,        
    // Clamps texture to edge pixel in tiled mode
    TEXTURE_WRAP_CLAMP,             
    // Mirrors and repeats the texture in tiled mode
    TEXTURE_WRAP_MIRROR_REPEAT,     
    // Mirrors and clamps to border the texture in tiled mode
    TEXTURE_WRAP_MIRROR_CLAMP       
} TextureWrap;

// Cubemap layouts
typedef enum {
    // Automatically detect layout type
    CUBEMAP_LAYOUT_AUTO_DETECT = 0,        
    // Layout is defined by a vertical line with faces
    CUBEMAP_LAYOUT_LINE_VERTICAL,          
    // Layout is defined by an horizontal line with faces
    CUBEMAP_LAYOUT_LINE_HORIZONTAL,        
    // Layout is defined by a 3x4 cross with cubemap faces
    CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR,    
    // Layout is defined by a 4x3 cross with cubemap faces
    CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE,    
    // Layout is defined by a panorama image (equirectangular map)
    CUBEMAP_LAYOUT_PANORAMA                
} CubemapLayout;

// Font type, defines generation method
typedef enum {
    // Default font generation, anti-aliased
    FONT_DEFAULT = 0,       
    // Bitmap font generation, no anti-aliasing
    FONT_BITMAP,            
    // SDF font generation, requires external shader
    FONT_SDF                
} FontType;

// Color blending modes (pre-defined)
typedef enum {
    // Blend textures considering alpha (default)
    BLEND_ALPHA = 0,        
    // Blend textures adding colors
    BLEND_ADDITIVE,         
    // Blend textures multiplying colors
    BLEND_MULTIPLIED,       
    // Blend textures adding colors (alternative)
    BLEND_ADD_COLORS,       
    // Blend textures subtracting colors (alternative)
    BLEND_SUBTRACT_COLORS,  
    // Belnd textures using custom src/dst factors (use rlSetBlendMode())
    BLEND_CUSTOM            
} BlendMode;

// Gestures
// NOTE: It could be used as flags to enable only some gestures
typedef enum {
    GESTURE_NONE        = 0,
    GESTURE_TAP         = 1,
    GESTURE_DOUBLETAP   = 2,
    GESTURE_HOLD        = 4,
    GESTURE_DRAG        = 8,
    GESTURE_SWIPE_RIGHT = 16,
    GESTURE_SWIPE_LEFT  = 32,
    GESTURE_SWIPE_UP    = 64,
    GESTURE_SWIPE_DOWN  = 128,
    GESTURE_PINCH_IN    = 256,
    GESTURE_PINCH_OUT   = 512
} Gestures;

// Camera system modes
typedef enum {
    CAMERA_CUSTOM = 0,
    CAMERA_FREE,
    CAMERA_ORBITAL,
    CAMERA_FIRST_PERSON,
    CAMERA_THIRD_PERSON
} CameraMode;

// Camera projection
typedef enum {
    CAMERA_PERSPECTIVE = 0,
    CAMERA_ORTHOGRAPHIC
} CameraProjection;

// N-patch layout
typedef enum {
    // Npatch layout: 3x3 tiles
    NPATCH_NINE_PATCH = 0,          
    // Npatch layout: 1x3 tiles
    NPATCH_THREE_PATCH_VERTICAL,    
    // Npatch layout: 3x1 tiles
    NPATCH_THREE_PATCH_HORIZONTAL   
} NPatchLayout;

// Callbacks to hook some internal functions
// WARNING: This callbacks are intended for advance users
// Logging: Redirect trace log messages
typedef void (*TraceLogCallback)(int logLevel, const char *text, va_list args);  
// FileIO: Load binary data
typedef unsigned char* (*LoadFileDataCallback)(const char* fileName, unsigned int* bytesRead);      
// FileIO: Save binary data
typedef bool (*SaveFileDataCallback)(const char *fileName, void *data, unsigned int bytesToWrite);  
// FileIO: Load text data
typedef char *(*LoadFileTextCallback)(const char* fileName);                
// FileIO: Save text data
typedef bool (*SaveFileTextCallback)(const char *fileName, char *text);     


#if defined(__cplusplus)
    // Prevents name mangling of functions
extern "C" {            
#endif

//------------------------------------------------------------------------------------
// Global Variables Definition
//------------------------------------------------------------------------------------
// It's lonely here...

//------------------------------------------------------------------------------------
// Window and Graphics Device Functions (Module: core)
//------------------------------------------------------------------------------------

// Window-related functions
// Initialize window and OpenGL context
RLAPI void InitWindow(int width, int height, const char *title);  
// Check if KEY_ESCAPE pressed or Close icon pressed
RLAPI bool WindowShouldClose(void);                               
// Close window and unload OpenGL context
RLAPI void CloseWindow(void);                                     
// Check if window has been initialized successfully
RLAPI bool IsWindowReady(void);                                   
// Check if window is currently fullscreen
RLAPI bool IsWindowFullscreen(void);                              
// Check if window is currently hidden (only PLATFORM_DESKTOP)
RLAPI bool IsWindowHidden(void);                                  
// Check if window is currently minimized (only PLATFORM_DESKTOP)
RLAPI bool IsWindowMinimized(void);                               
// Check if window is currently maximized (only PLATFORM_DESKTOP)
RLAPI bool IsWindowMaximized(void);                               
// Check if window is currently focused (only PLATFORM_DESKTOP)
RLAPI bool IsWindowFocused(void);                                 
// Check if window has been resized last frame
RLAPI bool IsWindowResized(void);                                 
// Check if one specific window flag is enabled
RLAPI bool IsWindowState(unsigned int flag);                      
// Set window configuration state using flags
RLAPI void SetWindowState(unsigned int flags);                    
// Clear window configuration state flags
RLAPI void ClearWindowState(unsigned int flags);                  
// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
RLAPI void ToggleFullscreen(void);                                
// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
RLAPI void MaximizeWindow(void);                                  
// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
RLAPI void MinimizeWindow(void);                                  
// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
RLAPI void RestoreWindow(void);                                   
// Set icon for window (only PLATFORM_DESKTOP)
RLAPI void SetWindowIcon(Image image);                            
// Set title for window (only PLATFORM_DESKTOP)
RLAPI void SetWindowTitle(const char *title);                     
// Set window position on screen (only PLATFORM_DESKTOP)
RLAPI void SetWindowPosition(int x, int y);                       
// Set monitor for the current window (fullscreen mode)
RLAPI void SetWindowMonitor(int monitor);                         
// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
RLAPI void SetWindowMinSize(int width, int height);               
// Set window dimensions
RLAPI void SetWindowSize(int width, int height);                  
// Get native window handle
RLAPI void *GetWindowHandle(void);                                
// Get current screen width
RLAPI int GetScreenWidth(void);                                   
// Get current screen height
RLAPI int GetScreenHeight(void);                                  
// Get number of connected monitors
RLAPI int GetMonitorCount(void);                                  
// Get current connected monitor
RLAPI int GetCurrentMonitor(void);                                
// Get specified monitor position
RLAPI Vector2 GetMonitorPosition(int monitor);                    
// Get specified monitor width (max available by monitor)
RLAPI int GetMonitorWidth(int monitor);                           
// Get specified monitor height (max available by monitor)
RLAPI int GetMonitorHeight(int monitor);                          
// Get specified monitor physical width in millimetres
RLAPI int GetMonitorPhysicalWidth(int monitor);                   
// Get specified monitor physical height in millimetres
RLAPI int GetMonitorPhysicalHeight(int monitor);                  
// Get specified monitor refresh rate
RLAPI int GetMonitorRefreshRate(int monitor);                     
// Get window position XY on monitor
RLAPI Vector2 GetWindowPosition(void);                            
// Get window scale DPI factor
RLAPI Vector2 GetWindowScaleDPI(void);                            
// Get the human-readable, UTF-8 encoded name of the primary monitor
RLAPI const char *GetMonitorName(int monitor);                    
// Set clipboard text content
RLAPI void SetClipboardText(const char *text);                    
// Get clipboard text content
RLAPI const char *GetClipboardText(void);                         

// Cursor-related functions
// Shows cursor
RLAPI void ShowCursor(void);                                      
// Hides cursor
RLAPI void HideCursor(void);                                      
// Check if cursor is not visible
RLAPI bool IsCursorHidden(void);                                  
// Enables cursor (unlock cursor)
RLAPI void EnableCursor(void);                                    
// Disables cursor (lock cursor)
RLAPI void DisableCursor(void);                                   
// Check if cursor is on the current screen.
RLAPI bool IsCursorOnScreen(void);                                

// Drawing-related functions
// Set background color (framebuffer clear color)
RLAPI void ClearBackground(Color color);                          
// Setup canvas (framebuffer) to start drawing
RLAPI void BeginDrawing(void);                                    
// End canvas drawing and swap buffers (double buffering)
RLAPI void EndDrawing(void);                                      
// Initialize 2D mode with custom camera (2D)
RLAPI void BeginMode2D(Camera2D camera);                          
// Ends 2D mode with custom camera
RLAPI void EndMode2D(void);                                       
// Initializes 3D mode with custom camera (3D)
RLAPI void BeginMode3D(Camera3D camera);                          
// Ends 3D mode and returns to default 2D orthographic mode
RLAPI void EndMode3D(void);                                       
// Initializes render texture for drawing
RLAPI void BeginTextureMode(RenderTexture2D target);              
// Ends drawing to render texture
RLAPI void EndTextureMode(void);                                  
// Begin custom shader drawing
RLAPI void BeginShaderMode(Shader shader);                        
// End custom shader drawing (use default shader)
RLAPI void EndShaderMode(void);                                   
// Begin blending mode (alpha, additive, multiplied)
RLAPI void BeginBlendMode(int mode);                              
// End blending mode (reset to default: alpha blending)
RLAPI void EndBlendMode(void);                                    
// Begin scissor mode (define screen area for following drawing)
RLAPI void BeginScissorMode(int x, int y, int width, int height); 
// End scissor mode
RLAPI void EndScissorMode(void);                                  
// Begin stereo rendering (requires VR simulator)
RLAPI void BeginVrStereoMode(VrStereoConfig config);              
// End stereo rendering (requires VR simulator)
RLAPI void EndVrStereoMode(void);                                 

// VR stereo config functions for VR simulator
// Load VR stereo config for VR simulator device parameters
RLAPI VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);     
// Unload VR stereo config
RLAPI void UnloadVrStereoConfig(VrStereoConfig config);           

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
// Load shader from files and bind default locations
RLAPI Shader LoadShader(const char *vsFileName, const char *fsFileName);   
// Load shader from code strings and bind default locations
RLAPI Shader LoadShaderFromMemory(const char *vsCode, const char *fsCode); 
// Get shader uniform location
RLAPI int GetShaderLocation(Shader shader, const char *uniformName);       
// Get shader attribute location
RLAPI int GetShaderLocationAttrib(Shader shader, const char *attribName);  
// Set shader uniform value
RLAPI void SetShaderValue(Shader shader, int locIndex, const void *value, int uniformType);               
// Set shader uniform value vector
RLAPI void SetShaderValueV(Shader shader, int locIndex, const void *value, int uniformType, int count);   
// Set shader uniform value (matrix 4x4)
RLAPI void SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);         
// Set shader uniform value for texture (sampler2d)
RLAPI void SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture); 
// Unload shader from GPU memory (VRAM)
RLAPI void UnloadShader(Shader shader);                                    

// Screen-space-related functions
// Returns a ray trace from mouse position
RLAPI Ray GetMouseRay(Vector2 mousePosition, Camera camera);      
// Returns camera transform matrix (view matrix)
RLAPI Matrix GetCameraMatrix(Camera camera);                      
// Returns camera 2d transform matrix
RLAPI Matrix GetCameraMatrix2D(Camera2D camera);                  
// Returns the screen space position for a 3d world space position
RLAPI Vector2 GetWorldToScreen(Vector3 position, Camera camera);  
// Returns size position for a 3d world space position
RLAPI Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height); 
// Returns the screen space position for a 2d camera world space position
RLAPI Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera); 
// Returns the world space position for a 2d camera screen space position
RLAPI Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera); 

// Timing-related functions
// Set target FPS (maximum)
RLAPI void SetTargetFPS(int fps);                                 
// Returns current FPS
RLAPI int GetFPS(void);                                           
// Returns time in seconds for last frame drawn (delta time)
RLAPI float GetFrameTime(void);                                   
// Returns elapsed time in seconds since InitWindow()
RLAPI double GetTime(void);                                       

// Misc. functions
// Returns a random value between min and max (both included)
RLAPI int GetRandomValue(int min, int max);                       
// Takes a screenshot of current screen (filename extension defines format)
RLAPI void TakeScreenshot(const char *fileName);                  
// Setup init configuration flags (view FLAGS)
RLAPI void SetConfigFlags(unsigned int flags);                    

// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR)
RLAPI void TraceLog(int logLevel, const char *text, ...);         
// Set the current threshold (minimum) log level
RLAPI void SetTraceLogLevel(int logLevel);                        
// Internal memory allocator
RLAPI void *MemAlloc(int size);                                   
// Internal memory reallocator
RLAPI void *MemRealloc(void *ptr, int size);                      
// Internal memory free
RLAPI void MemFree(void *ptr);                                    

// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users
// Set custom trace log
RLAPI void SetTraceLogCallback(TraceLogCallback callback);         
// Set custom file binary data loader
RLAPI void SetLoadFileDataCallback(LoadFileDataCallback callback); 
// Set custom file binary data saver
RLAPI void SetSaveFileDataCallback(SaveFileDataCallback callback); 
// Set custom file text data loader
RLAPI void SetLoadFileTextCallback(LoadFileTextCallback callback); 
// Set custom file text data saver
RLAPI void SetSaveFileTextCallback(SaveFileTextCallback callback); 

// Files management functions
// Load file data as byte array (read)
RLAPI unsigned char *LoadFileData(const char *fileName, unsigned int *bytesRead);     
// Unload file data allocated by LoadFileData()
RLAPI void UnloadFileData(unsigned char *data);                   
// Save data to file from byte array (write), returns true on success
RLAPI bool SaveFileData(const char *fileName, void *data, unsigned int bytesToWrite); 
// Load text data from file (read), returns a '\0' terminated string
RLAPI char *LoadFileText(const char *fileName);                   
// Unload file text data allocated by LoadFileText()
RLAPI void UnloadFileText(unsigned char *text);                   
// Save text data to file (write), string must be '\0' terminated, returns true on success
RLAPI bool SaveFileText(const char *fileName, char *text);        
// Check if file exists
RLAPI bool FileExists(const char *fileName);                      
// Check if a directory path exists
RLAPI bool DirectoryExists(const char *dirPath);                  
// Check file extension (including point: .png, .wav)
RLAPI bool IsFileExtension(const char *fileName, const char *ext);
// Get pointer to extension for a filename string (includes dot: ".png")
RLAPI const char *GetFileExtension(const char *fileName);         
// Get pointer to filename for a path string
RLAPI const char *GetFileName(const char *filePath);              
// Get filename string without extension (uses static string)
RLAPI const char *GetFileNameWithoutExt(const char *filePath);    
// Get full path for a given fileName with path (uses static string)
RLAPI const char *GetDirectoryPath(const char *filePath);         
// Get previous directory path for a given path (uses static string)
RLAPI const char *GetPrevDirectoryPath(const char *dirPath);      
// Get current working directory (uses static string)
RLAPI const char *GetWorkingDirectory(void);                      
// Get filenames in a directory path (memory should be freed)
RLAPI char **GetDirectoryFiles(const char *dirPath, int *count);  
// Clear directory files paths buffers (free memory)
RLAPI void ClearDirectoryFiles(void);                             
// Change working directory, return true on success
RLAPI bool ChangeDirectory(const char *dir);                      
// Check if a file has been dropped into window
RLAPI bool IsFileDropped(void);                                   
// Get dropped files names (memory should be freed)
RLAPI char **GetDroppedFiles(int *count);                         
// Clear dropped files paths buffer (free memory)
RLAPI void ClearDroppedFiles(void);                               
// Get file modification time (last write time)
RLAPI long GetFileModTime(const char *fileName);                  

// Compress data (DEFLATE algorithm)
RLAPI unsigned char *CompressData(unsigned char *data, int dataLength, int *compDataLength);        
// Decompress data (DEFLATE algorithm)
RLAPI unsigned char *DecompressData(unsigned char *compData, int compDataLength, int *dataLength);  

// Persistent storage management
// Save integer value to storage file (to defined position), returns true on success
RLAPI bool SaveStorageValue(unsigned int position, int value);    
// Load integer value from storage file (from defined position)
RLAPI int LoadStorageValue(unsigned int position);                

// Open URL with default system browser (if available)
RLAPI void OpenURL(const char *url);                              

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
// Detect if a key has been pressed once
RLAPI bool IsKeyPressed(int key);                             
// Detect if a key is being pressed
RLAPI bool IsKeyDown(int key);                                
// Detect if a key has been released once
RLAPI bool IsKeyReleased(int key);                            
// Detect if a key is NOT being pressed
RLAPI bool IsKeyUp(int key);                                  
// Set a custom key to exit program (default is ESC)
RLAPI void SetExitKey(int key);                               
// Get key pressed (keycode), call it multiple times for keys queued
RLAPI int GetKeyPressed(void);                                
// Get char pressed (unicode), call it multiple times for chars queued
RLAPI int GetCharPressed(void);                               

// Input-related functions: gamepads
// Detect if a gamepad is available
RLAPI bool IsGamepadAvailable(int gamepad);                   
// Check gamepad name (if available)
RLAPI bool IsGamepadName(int gamepad, const char *name);      
// Return gamepad internal name id
RLAPI const char *GetGamepadName(int gamepad);                
// Detect if a gamepad button has been pressed once
RLAPI bool IsGamepadButtonPressed(int gamepad, int button);   
// Detect if a gamepad button is being pressed
RLAPI bool IsGamepadButtonDown(int gamepad, int button);      
// Detect if a gamepad button has been released once
RLAPI bool IsGamepadButtonReleased(int gamepad, int button);  
// Detect if a gamepad button is NOT being pressed
RLAPI bool IsGamepadButtonUp(int gamepad, int button);        
// Get the last gamepad button pressed
RLAPI int GetGamepadButtonPressed(void);                      
// Return gamepad axis count for a gamepad
RLAPI int GetGamepadAxisCount(int gamepad);                   
// Return axis movement value for a gamepad axis
RLAPI float GetGamepadAxisMovement(int gamepad, int axis);    
// Set internal gamepad mappings (SDL_GameControllerDB)
RLAPI int SetGamepadMappings(const char *mappings);           

// Input-related functions: mouse
// Detect if a mouse button has been pressed once
RLAPI bool IsMouseButtonPressed(int button);                  
// Detect if a mouse button is being pressed
RLAPI bool IsMouseButtonDown(int button);                     
// Detect if a mouse button has been released once
RLAPI bool IsMouseButtonReleased(int button);                 
// Detect if a mouse button is NOT being pressed
RLAPI bool IsMouseButtonUp(int button);                       
// Returns mouse position X
RLAPI int GetMouseX(void);                                    
// Returns mouse position Y
RLAPI int GetMouseY(void);                                    
// Returns mouse position XY
RLAPI Vector2 GetMousePosition(void);                         
// Set mouse position XY
RLAPI void SetMousePosition(int x, int y);                    
// Set mouse offset
RLAPI void SetMouseOffset(int offsetX, int offsetY);          
// Set mouse scaling
RLAPI void SetMouseScale(float scaleX, float scaleY);         
// Returns mouse wheel movement Y
RLAPI float GetMouseWheelMove(void);                          
// Set mouse cursor
RLAPI void SetMouseCursor(int cursor);                        

// Input-related functions: touch
// Returns touch position X for touch point 0 (relative to screen size)
RLAPI int GetTouchX(void);                                    
// Returns touch position Y for touch point 0 (relative to screen size)
RLAPI int GetTouchY(void);                                    
// Returns touch position XY for a touch point index (relative to screen size)
RLAPI Vector2 GetTouchPosition(int index);                    

//------------------------------------------------------------------------------------
// Gestures and Touch Handling Functions (Module: gestures)
//------------------------------------------------------------------------------------
// Enable a set of gestures using flags
RLAPI void SetGesturesEnabled(unsigned int flags);      
// Check if a gesture have been detected
RLAPI bool IsGestureDetected(int gesture);              
// Get latest detected gesture
RLAPI int GetGestureDetected(void);                     
// Get touch points count
RLAPI int GetTouchPointsCount(void);                    
// Get gesture hold time in milliseconds
RLAPI float GetGestureHoldDuration(void);               
// Get gesture drag vector
RLAPI Vector2 GetGestureDragVector(void);               
// Get gesture drag angle
RLAPI float GetGestureDragAngle(void);                  
// Get gesture pinch delta
RLAPI Vector2 GetGesturePinchVector(void);              
// Get gesture pinch angle
RLAPI float GetGesturePinchAngle(void);                 

//------------------------------------------------------------------------------------
// Camera System Functions (Module: camera)
//------------------------------------------------------------------------------------
// Set camera mode (multiple camera modes available)
RLAPI void SetCameraMode(Camera camera, int mode);      
// Update camera position for selected mode
RLAPI void UpdateCamera(Camera *camera);                

// Set camera pan key to combine with mouse movement (free camera)
RLAPI void SetCameraPanControl(int keyPan);             
// Set camera alt key to combine with mouse movement (free camera)
RLAPI void SetCameraAltControl(int keyAlt);             
// Set camera smooth zoom key to combine with mouse (free camera)
RLAPI void SetCameraSmoothZoomControl(int keySmoothZoom); 
// Set camera move controls (1st person and 3rd person cameras)
RLAPI void SetCameraMoveControls(int keyFront, int keyBack, int keyRight, int keyLeft, int keyUp, int keyDown); 

//------------------------------------------------------------------------------------
// Basic Shapes Drawing Functions (Module: shapes)
//------------------------------------------------------------------------------------
// Set texture and rectangle to be used on shapes drawing
// NOTE: It can be useful when using basic shapes and one single font,
// defining a font char white rectangle would allow drawing everything in a single draw call
RLAPI void SetShapesTexture(Texture2D texture, Rectangle source);

// Basic shapes drawing functions
// Draw a pixel
RLAPI void DrawPixel(int posX, int posY, Color color);                                                   
// Draw a pixel (Vector version)
RLAPI void DrawPixelV(Vector2 position, Color color);                                                    
// Draw a line
RLAPI void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);                
// Draw a line (Vector version)
RLAPI void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);                                     
// Draw a line defining thickness
RLAPI void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);                       
// Draw a line using cubic-bezier curves in-out
RLAPI void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);                   
//Draw line using quadratic bezier curves with a control point
RLAPI void DrawLineBezierQuad(Vector2 startPos, Vector2 endPos, Vector2 controlPos, float thick, Color color); 
// Draw lines sequence
RLAPI void DrawLineStrip(Vector2 *points, int pointsCount, Color color);                                 
// Draw a color-filled circle
RLAPI void DrawCircle(int centerX, int centerY, float radius, Color color);                              
// Draw a piece of a circle
RLAPI void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);      
// Draw circle sector outline
RLAPI void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color); 
// Draw a gradient-filled circle
RLAPI void DrawCircleGradient(int centerX, int centerY, float radius, Color color1, Color color2);       
// Draw a color-filled circle (Vector version)
RLAPI void DrawCircleV(Vector2 center, float radius, Color color);                                       
// Draw circle outline
RLAPI void DrawCircleLines(int centerX, int centerY, float radius, Color color);                         
// Draw ellipse
RLAPI void DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);             
// Draw ellipse outline
RLAPI void DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);        
// Draw ring
RLAPI void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color); 
// Draw ring outline
RLAPI void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);    
// Draw a color-filled rectangle
RLAPI void DrawRectangle(int posX, int posY, int width, int height, Color color);                        
// Draw a color-filled rectangle (Vector version)
RLAPI void DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  
// Draw a color-filled rectangle
RLAPI void DrawRectangleRec(Rectangle rec, Color color);                                                 
// Draw a color-filled rectangle with pro parameters
RLAPI void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 
// Draw a vertical-gradient-filled rectangle
RLAPI void DrawRectangleGradientV(int posX, int posY, int width, int height, Color color1, Color color2);
// Draw a horizontal-gradient-filled rectangle
RLAPI void DrawRectangleGradientH(int posX, int posY, int width, int height, Color color1, Color color2);
// Draw a gradient-filled rectangle with custom vertex colors
RLAPI void DrawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4);       
// Draw rectangle outline
RLAPI void DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   
// Draw rectangle outline with extended parameters
RLAPI void DrawRectangleLinesEx(Rectangle rec, int lineThick, Color color);                              
// Draw rectangle with rounded edges
RLAPI void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);              
// Draw rectangle with rounded edges outline
RLAPI void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, int lineThick, Color color); 
// Draw a color-filled triangle (vertex in counter-clockwise order!)
RLAPI void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                
// Draw triangle outline (vertex in counter-clockwise order!)
RLAPI void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           
// Draw a triangle fan defined by points (first vertex is the center)
RLAPI void DrawTriangleFan(Vector2 *points, int pointsCount, Color color);                               
// Draw a triangle strip defined by points
RLAPI void DrawTriangleStrip(Vector2 *points, int pointsCount, Color color);                             
// Draw a regular polygon (Vector version)
RLAPI void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);               
// Draw a polygon outline of n sides
RLAPI void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);          

// Basic shapes collision detection functions
// Check collision between two rectangles
RLAPI bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);                                           
// Check collision between two circles
RLAPI bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);        
// Check collision between circle and rectangle
RLAPI bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);                         
// Check if point is inside rectangle
RLAPI bool CheckCollisionPointRec(Vector2 point, Rectangle rec);                                         
// Check if point is inside circle
RLAPI bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);                       
// Check if point is inside a triangle
RLAPI bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);               
// Check the collision between two lines defined by two points each, returns collision point by reference
RLAPI bool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint); 
// Get collision rectangle for two rectangles collision
RLAPI Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);                                         

//------------------------------------------------------------------------------------
// Texture Loading and Drawing Functions (Module: textures)
//------------------------------------------------------------------------------------

// Image loading functions
// NOTE: This functions do not require GPU access
// Load image from file into CPU memory (RAM)
RLAPI Image LoadImage(const char *fileName);                                                             
// Load image from RAW file data
RLAPI Image LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize);       
// Load image sequence from file (frames appended to image.data)
RLAPI Image LoadImageAnim(const char *fileName, int *frames);                                            
// Load image from memory buffer, fileType refers to extension: i.e. ".png"
RLAPI Image LoadImageFromMemory(const char *fileType, const unsigned char *fileData, int dataSize);      
// Unload image from CPU memory (RAM)
RLAPI void UnloadImage(Image image);                                                                     
// Export image data to file, returns true on success
RLAPI bool ExportImage(Image image, const char *fileName);                                               
// Export image as code file defining an array of bytes, returns true on success
RLAPI bool ExportImageAsCode(Image image, const char *fileName);                                         

// Image generation functions
// Generate image: plain color
RLAPI Image GenImageColor(int width, int height, Color color);                                           
// Generate image: vertical gradient
RLAPI Image GenImageGradientV(int width, int height, Color top, Color bottom);                           
// Generate image: horizontal gradient
RLAPI Image GenImageGradientH(int width, int height, Color left, Color right);                           
// Generate image: radial gradient
RLAPI Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);      
// Generate image: checked
RLAPI Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);    
// Generate image: white noise
RLAPI Image GenImageWhiteNoise(int width, int height, float factor);                                     
// Generate image: perlin noise
RLAPI Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);           
// Generate image: cellular algorithm. Bigger tileSize means bigger cells
RLAPI Image GenImageCellular(int width, int height, int tileSize);                                       

// Image manipulation functions
// Create an image duplicate (useful for transformations)
RLAPI Image ImageCopy(Image image);                                                                      
// Create an image from another image piece
RLAPI Image ImageFromImage(Image image, Rectangle rec);                                                  
// Create an image from text (default font)
RLAPI Image ImageText(const char *text, int fontSize, Color color);                                      
// Create an image from text (custom sprite font)
RLAPI Image ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint);         
// Convert image data to desired format
RLAPI void ImageFormat(Image *image, int newFormat);                                                     
// Convert image to POT (power-of-two)
RLAPI void ImageToPOT(Image *image, Color fill);                                                         
// Crop an image to a defined rectangle
RLAPI void ImageCrop(Image *image, Rectangle crop);                                                      
// Crop image depending on alpha value
RLAPI void ImageAlphaCrop(Image *image, float threshold);                                                
// Clear alpha channel to desired color
RLAPI void ImageAlphaClear(Image *image, Color color, float threshold);                                  
// Apply alpha mask to image
RLAPI void ImageAlphaMask(Image *image, Image alphaMask);                                                
// Premultiply alpha channel
RLAPI void ImageAlphaPremultiply(Image *image);                                                          
// Resize image (Bicubic scaling algorithm)
RLAPI void ImageResize(Image *image, int newWidth, int newHeight);                                       
// Resize image (Nearest-Neighbor scaling algorithm)
RLAPI void ImageResizeNN(Image *image, int newWidth,int newHeight);                                      
// Resize canvas and fill with color
RLAPI void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill);  
// Generate all mipmap levels for a provided image
RLAPI void ImageMipmaps(Image *image);                                                                   
// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
RLAPI void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);                            
// Flip image vertically
RLAPI void ImageFlipVertical(Image *image);                                                              
// Flip image horizontally
RLAPI void ImageFlipHorizontal(Image *image);                                                            
// Rotate image clockwise 90deg
RLAPI void ImageRotateCW(Image *image);                                                                  
// Rotate image counter-clockwise 90deg
RLAPI void ImageRotateCCW(Image *image);                                                                 
// Modify image color: tint
RLAPI void ImageColorTint(Image *image, Color color);                                                    
// Modify image color: invert
RLAPI void ImageColorInvert(Image *image);                                                               
// Modify image color: grayscale
RLAPI void ImageColorGrayscale(Image *image);                                                            
// Modify image color: contrast (-100 to 100)
RLAPI void ImageColorContrast(Image *image, float contrast);                                             
// Modify image color: brightness (-255 to 255)
RLAPI void ImageColorBrightness(Image *image, int brightness);                                           
// Modify image color: replace color
RLAPI void ImageColorReplace(Image *image, Color color, Color replace);                                  
// Load color data from image as a Color array (RGBA - 32bit)
RLAPI Color *LoadImageColors(Image image);                                                               
// Load colors palette from image as a Color array (RGBA - 32bit)
RLAPI Color *LoadImagePalette(Image image, int maxPaletteSize, int *colorsCount);                        
// Unload color data loaded with LoadImageColors()
RLAPI void UnloadImageColors(Color *colors);                                                             
// Unload colors palette loaded with LoadImagePalette()
RLAPI void UnloadImagePalette(Color *colors);                                                            
// Get image alpha border rectangle
RLAPI Rectangle GetImageAlphaBorder(Image image, float threshold);                                       

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)
// Clear image background with given color
RLAPI void ImageClearBackground(Image *dst, Color color);                                                
// Draw pixel within an image
RLAPI void ImageDrawPixel(Image *dst, int posX, int posY, Color color);                                  
// Draw pixel within an image (Vector version)
RLAPI void ImageDrawPixelV(Image *dst, Vector2 position, Color color);                                   
// Draw line within an image
RLAPI void ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color); 
// Draw line within an image (Vector version)
RLAPI void ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color);                          
// Draw circle within an image
RLAPI void ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color);               
// Draw circle within an image (Vector version)
RLAPI void ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color);                        
// Draw rectangle within an image
RLAPI void ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color);       
// Draw rectangle within an image (Vector version)
RLAPI void ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color);                 
// Draw rectangle within an image
RLAPI void ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color);                                
// Draw rectangle lines within an image
RLAPI void ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color);                   
// Draw a source image within a destination image (tint applied to source)
RLAPI void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);             
// Draw text (using default font) within an image (destination)
RLAPI void ImageDrawText(Image *dst, const char *text, int posX, int posY, int fontSize, Color color);   
// Draw text (custom sprite font) within an image (destination)
RLAPI void ImageDrawTextEx(Image *dst, Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint); 

// Texture loading functions
// NOTE: These functions require GPU access
// Load texture from file into GPU memory (VRAM)
RLAPI Texture2D LoadTexture(const char *fileName);                                                       
// Load texture from image data
RLAPI Texture2D LoadTextureFromImage(Image image);                                                       
// Load cubemap from image, multiple image cubemap layouts supported
RLAPI TextureCubemap LoadTextureCubemap(Image image, int layout);                                        
// Load texture for rendering (framebuffer)
RLAPI RenderTexture2D LoadRenderTexture(int width, int height);                                          
// Unload texture from GPU memory (VRAM)
RLAPI void UnloadTexture(Texture2D texture);                                                             
// Unload render texture from GPU memory (VRAM)
RLAPI void UnloadRenderTexture(RenderTexture2D target);                                                  
// Update GPU texture with new data
RLAPI void UpdateTexture(Texture2D texture, const void *pixels);                                         
// Update GPU texture rectangle with new data
RLAPI void UpdateTextureRec(Texture2D texture, Rectangle rec, const void *pixels);                       
// Get pixel data from GPU texture and return an Image
RLAPI Image GetTextureData(Texture2D texture);                                                           
// Get pixel data from screen buffer and return an Image (screenshot)
RLAPI Image GetScreenData(void);                                                                         

// Texture configuration functions
// Generate GPU mipmaps for a texture
RLAPI void GenTextureMipmaps(Texture2D *texture);                                                        
// Set texture scaling filter mode
RLAPI void SetTextureFilter(Texture2D texture, int filter);                                              
// Set texture wrapping mode
RLAPI void SetTextureWrap(Texture2D texture, int wrap);                                                  

// Texture drawing functions
// Draw a Texture2D
RLAPI void DrawTexture(Texture2D texture, int posX, int posY, Color tint);                               
// Draw a Texture2D with position defined as Vector2
RLAPI void DrawTextureV(Texture2D texture, Vector2 position, Color tint);                                
// Draw a Texture2D with extended parameters
RLAPI void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);  
// Draw a part of a texture defined by a rectangle
RLAPI void DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);            
// Draw texture quad with tiling and offset parameters
RLAPI void DrawTextureQuad(Texture2D texture, Vector2 tiling, Vector2 offset, Rectangle quad, Color tint);  
// Draw part of a texture (defined by a rectangle) with rotation and scale tiled into dest.
RLAPI void DrawTextureTiled(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, float scale, Color tint);      
// Draw a part of a texture defined by a rectangle with 'pro' parameters
RLAPI void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);           
// Draws a texture (or part of it) that stretches or shrinks nicely
RLAPI void DrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint);   
// Draw a textured polygon
RLAPI void DrawTexturePoly(Texture2D texture, Vector2 center, Vector2 *points, Vector2 *texcoords, int pointsCount, Color tint);      

// Color/pixel related functions
// Returns color with alpha applied, alpha goes from 0.0f to 1.0f
RLAPI Color Fade(Color color, float alpha);                                 
// Returns hexadecimal value for a Color
RLAPI int ColorToInt(Color color);                                          
// Returns Color normalized as float [0..1]
RLAPI Vector4 ColorNormalize(Color color);                                  
// Returns Color from normalized values [0..1]
RLAPI Color ColorFromNormalized(Vector4 normalized);                        
// Returns HSV values for a Color, hue [0..360], saturation/value [0..1]
RLAPI Vector3 ColorToHSV(Color color);                                      
// Returns a Color from HSV values, hue [0..360], saturation/value [0..1]
RLAPI Color ColorFromHSV(float hue, float saturation, float value);         
// Returns color with alpha applied, alpha goes from 0.0f to 1.0f
RLAPI Color ColorAlpha(Color color, float alpha);                           
// Returns src alpha-blended into dst color with tint
RLAPI Color ColorAlphaBlend(Color dst, Color src, Color tint);              
// Get Color structure from hexadecimal value
RLAPI Color GetColor(int hexValue);                                         
// Get Color from a source pixel pointer of certain format
RLAPI Color GetPixelColor(void *srcPtr, int format);                        
// Set color formatted into destination pixel pointer
RLAPI void SetPixelColor(void *dstPtr, Color color, int format);            
// Get pixel data size in bytes for certain format
RLAPI int GetPixelDataSize(int width, int height, int format);              

//------------------------------------------------------------------------------------
// Font Loading and Text Drawing Functions (Module: text)
//------------------------------------------------------------------------------------

// Font loading/unloading functions
// Get the default Font
RLAPI Font GetFontDefault(void);                                                            
// Load font from file into GPU memory (VRAM)
RLAPI Font LoadFont(const char *fileName);                                                  
// Load font from file with extended parameters
RLAPI Font LoadFontEx(const char *fileName, int fontSize, int *fontChars, int charsCount);  
// Load font from Image (XNA style)
RLAPI Font LoadFontFromImage(Image image, Color key, int firstChar);                        
// Load font from memory buffer, fileType refers to extension: i.e. ".ttf"
RLAPI Font LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, int *fontChars, int charsCount); 
// Load font data for further use
RLAPI CharInfo *LoadFontData(const unsigned char *fileData, int dataSize, int fontSize, int *fontChars, int charsCount, int type);      
// Generate image font atlas using chars info
RLAPI Image GenImageFontAtlas(const CharInfo *chars, Rectangle **recs, int charsCount, int fontSize, int padding, int packMethod);      
// Unload font chars info data (RAM)
RLAPI void UnloadFontData(CharInfo *chars, int charsCount);                                 
// Unload Font from GPU memory (VRAM)
RLAPI void UnloadFont(Font font);                                                           

// Text drawing functions
// Draw current FPS
RLAPI void DrawFPS(int posX, int posY);                                                     
// Draw text (using default font)
RLAPI void DrawText(const char *text, int posX, int posY, int fontSize, Color color);       
// Draw text using font and additional parameters
RLAPI void DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint);                
// Draw text using font inside rectangle limits
RLAPI void DrawTextRec(Font font, const char *text, Rectangle rec, float fontSize, float spacing, bool wordWrap, Color tint);   
RLAPI void DrawTextRecEx(Font font, const char *text, Rectangle rec, float fontSize, float spacing, bool wordWrap, Color tint,
                         // Draw text using font inside rectangle limits with support for text selection
                         int selectStart, int selectLength, Color selectTint, Color selectBackTint);    
// Draw one character (codepoint)
RLAPI void DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint);   

// Text misc. functions
// Measure string width for default font
RLAPI int MeasureText(const char *text, int fontSize);                                      
// Measure string size for Font
RLAPI Vector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);    
// Get index position for a unicode character on font
RLAPI int GetGlyphIndex(Font font, int codepoint);                                          

// Text strings management functions (no utf8 strings, only byte chars)
// NOTE: Some strings allocate memory internally for returned strings, just be careful!
// Copy one string to another, returns bytes copied
RLAPI int TextCopy(char *dst, const char *src);                                             
// Check if two text string are equal
RLAPI bool TextIsEqual(const char *text1, const char *text2);                               
// Get text length, checks for '\0' ending
RLAPI unsigned int TextLength(const char *text);                                            
// Text formatting with variables (sprintf style)
RLAPI const char *TextFormat(const char *text, ...);                                        
// Get a piece of a text string
RLAPI const char *TextSubtext(const char *text, int position, int length);                  
// Replace text string (memory must be freed!)
RLAPI char *TextReplace(char *text, const char *replace, const char *by);                   
// Insert text in a position (memory must be freed!)
RLAPI char *TextInsert(const char *text, const char *insert, int position);                 
// Join text strings with delimiter
RLAPI const char *TextJoin(const char **textList, int count, const char *delimiter);        
// Split text into multiple strings
RLAPI const char **TextSplit(const char *text, char delimiter, int *count);                 
// Append text at specific position and move cursor!
RLAPI void TextAppend(char *text, const char *append, int *position);                       
// Find first text occurrence within a string
RLAPI int TextFindIndex(const char *text, const char *find);                                
// Get upper case version of provided string
RLAPI const char *TextToUpper(const char *text);                      
// Get lower case version of provided string
RLAPI const char *TextToLower(const char *text);                      
// Get Pascal case notation version of provided string
RLAPI const char *TextToPascal(const char *text);                     
// Get integer value from text (negative values not supported)
RLAPI int TextToInteger(const char *text);                            
// Encode text codepoint into utf8 text (memory must be freed!)
RLAPI char *TextToUtf8(int *codepoints, int length);                  

// UTF8 text strings management functions
// Get all codepoints in a string, codepoints count returned by parameters
RLAPI int *GetCodepoints(const char *text, int *count);               
// Get total number of characters (codepoints) in a UTF8 encoded string
RLAPI int GetCodepointsCount(const char *text);                       
// Returns next codepoint in a UTF8 encoded string; 0x3f('?') is returned on failure
RLAPI int GetNextCodepoint(const char *text, int *bytesProcessed);    
// Encode codepoint into utf8 text (char array length returned as parameter)
RLAPI const char *CodepointToUtf8(int codepoint, int *byteLength);    

//------------------------------------------------------------------------------------
// Basic 3d Shapes Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Basic geometric 3D shapes drawing functions
// Draw a line in 3D world space
RLAPI void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);                                    
// Draw a point in 3D space, actually a small line
RLAPI void DrawPoint3D(Vector3 position, Color color);                                                   
// Draw a circle in 3D world space
RLAPI void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color); 
// Draw a color-filled triangle (vertex in counter-clockwise order!)
RLAPI void DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color);                              
// Draw a triangle strip defined by points
RLAPI void DrawTriangleStrip3D(Vector3 *points, int pointsCount, Color color);                           
// Draw cube
RLAPI void DrawCube(Vector3 position, float width, float height, float length, Color color);             
// Draw cube (Vector version)
RLAPI void DrawCubeV(Vector3 position, Vector3 size, Color color);                                       
// Draw cube wires
RLAPI void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);        
// Draw cube wires (Vector version)
RLAPI void DrawCubeWiresV(Vector3 position, Vector3 size, Color color);                                  
// Draw cube textured
RLAPI void DrawCubeTexture(Texture2D texture, Vector3 position, float width, float height, float length, Color color); 
// Draw sphere
RLAPI void DrawSphere(Vector3 centerPos, float radius, Color color);                                     
// Draw sphere with extended parameters
RLAPI void DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);            
// Draw sphere wires
RLAPI void DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);         
// Draw a cylinder/cone
RLAPI void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); 
// Draw a cylinder/cone wires
RLAPI void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); 
// Draw a plane XZ
RLAPI void DrawPlane(Vector3 centerPos, Vector2 size, Color color);                                      
// Draw a ray line
RLAPI void DrawRay(Ray ray, Color color);                                                                
// Draw a grid (centered at (0, 0, 0))
RLAPI void DrawGrid(int slices, float spacing);                                                          

//------------------------------------------------------------------------------------
// Model 3d Loading and Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Model loading/unloading functions
// Load model from files (meshes and materials)
RLAPI Model LoadModel(const char *fileName);                                                
// Load model from generated mesh (default material)
RLAPI Model LoadModelFromMesh(Mesh mesh);                                                   
// Unload model (including meshes) from memory (RAM and/or VRAM)
RLAPI void UnloadModel(Model model);                                                        
// Unload model (but not meshes) from memory (RAM and/or VRAM)
RLAPI void UnloadModelKeepMeshes(Model model);                                              

// Mesh loading/unloading functions
// Upload mesh vertex data in GPU and provide VAO/VBO ids
RLAPI void UploadMesh(Mesh *mesh, bool dynamic);                                            
// Update mesh vertex data in GPU for a specific buffer index
RLAPI void UpdateMeshBuffer(Mesh mesh, int index, void *data, int dataSize, int offset);    
// Draw a 3d mesh with material and transform
RLAPI void DrawMesh(Mesh mesh, Material material, Matrix transform);                        
// Draw multiple mesh instances with material and different transforms
RLAPI void DrawMeshInstanced(Mesh mesh, Material material, Matrix *transforms, int instances); 
// Unload mesh data from CPU and GPU
RLAPI void UnloadMesh(Mesh mesh);                                                           
// Export mesh data to file, returns true on success
RLAPI bool ExportMesh(Mesh mesh, const char *fileName);                                     

// Material loading/unloading functions
// Load materials from model file
RLAPI Material *LoadMaterials(const char *fileName, int *materialCount);                    
// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
RLAPI Material LoadMaterialDefault(void);                                                   
// Unload material from GPU memory (VRAM)
RLAPI void UnloadMaterial(Material material);                                               
// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
RLAPI void SetMaterialTexture(Material *material, int mapType, Texture2D texture);          
// Set material for a mesh
RLAPI void SetModelMeshMaterial(Model *model, int meshId, int materialId);                  

// Model animations loading/unloading functions
// Load model animations from file
RLAPI ModelAnimation *LoadModelAnimations(const char *fileName, int *animsCount);           
// Update model animation pose
RLAPI void UpdateModelAnimation(Model model, ModelAnimation anim, int frame);               
// Unload animation data
RLAPI void UnloadModelAnimation(ModelAnimation anim);                                       
// Unload animation array data
RLAPI void UnloadModelAnimations(ModelAnimation* animations, unsigned int count);           
// Check model animation skeleton match
RLAPI bool IsModelAnimationValid(Model model, ModelAnimation anim);                         

// Mesh generation functions
// Generate polygonal mesh
RLAPI Mesh GenMeshPoly(int sides, float radius);                                            
// Generate plane mesh (with subdivisions)
RLAPI Mesh GenMeshPlane(float width, float length, int resX, int resZ);                     
// Generate cuboid mesh
RLAPI Mesh GenMeshCube(float width, float height, float length);                            
// Generate sphere mesh (standard sphere)
RLAPI Mesh GenMeshSphere(float radius, int rings, int slices);                              
// Generate half-sphere mesh (no bottom cap)
RLAPI Mesh GenMeshHemiSphere(float radius, int rings, int slices);                          
// Generate cylinder mesh
RLAPI Mesh GenMeshCylinder(float radius, float height, int slices);                         
// Generate torus mesh
RLAPI Mesh GenMeshTorus(float radius, float size, int radSeg, int sides);                   
// Generate trefoil knot mesh
RLAPI Mesh GenMeshKnot(float radius, float size, int radSeg, int sides);                    
// Generate heightmap mesh from image data
RLAPI Mesh GenMeshHeightmap(Image heightmap, Vector3 size);                                 
// Generate cubes-based map mesh from image data
RLAPI Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);                               

// Mesh manipulation functions
// Compute mesh bounding box limits
RLAPI BoundingBox MeshBoundingBox(Mesh mesh);                                               
// Compute mesh tangents
RLAPI void MeshTangents(Mesh *mesh);                                                        
// Compute mesh binormals
RLAPI void MeshBinormals(Mesh *mesh);                                                       

// Model drawing functions
// Draw a model (with texture if set)
RLAPI void DrawModel(Model model, Vector3 position, float scale, Color tint);                           
// Draw a model with extended parameters
RLAPI void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); 
// Draw a model wires (with texture if set)
RLAPI void DrawModelWires(Model model, Vector3 position, float scale, Color tint);                      
// Draw a model wires (with texture if set) with extended parameters
RLAPI void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); 
// Draw bounding box (wires)
RLAPI void DrawBoundingBox(BoundingBox box, Color color);                                               
// Draw a billboard texture
RLAPI void DrawBillboard(Camera camera, Texture2D texture, Vector3 center, float size, Color tint);     
// Draw a billboard texture defined by source
RLAPI void DrawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 center, float size, Color tint); 

// Collision detection functions
// Detect collision between two spheres
RLAPI bool CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2);       
// Detect collision between two bounding boxes
RLAPI bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);                                     
// Detect collision between box and sphere
RLAPI bool CheckCollisionBoxSphere(BoundingBox box, Vector3 center, float radius);                      
// Detect collision between ray and sphere
RLAPI bool CheckCollisionRaySphere(Ray ray, Vector3 center, float radius);                              
// Detect collision between ray and sphere, returns collision point
RLAPI bool CheckCollisionRaySphereEx(Ray ray, Vector3 center, float radius, Vector3 *collisionPoint);   
// Detect collision between ray and box
RLAPI bool CheckCollisionRayBox(Ray ray, BoundingBox box);                                              
// Get collision info between ray and mesh
RLAPI RayHitInfo GetCollisionRayMesh(Ray ray, Mesh mesh, Matrix transform);                             
// Get collision info between ray and model
RLAPI RayHitInfo GetCollisionRayModel(Ray ray, Model model);                                            
// Get collision info between ray and triangle
RLAPI RayHitInfo GetCollisionRayTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);                  
// Get collision info between ray and ground plane (Y-normal plane)
RLAPI RayHitInfo GetCollisionRayGround(Ray ray, float groundHeight);                                    

//------------------------------------------------------------------------------------
// Audio Loading and Playing Functions (Module: audio)
//------------------------------------------------------------------------------------

// Audio device management functions
// Initialize audio device and context
RLAPI void InitAudioDevice(void);                                     
// Close the audio device and context
RLAPI void CloseAudioDevice(void);                                    
// Check if audio device has been initialized successfully
RLAPI bool IsAudioDeviceReady(void);                                  
// Set master volume (listener)
RLAPI void SetMasterVolume(float volume);                             

// Wave/Sound loading/unloading functions
// Load wave data from file
RLAPI Wave LoadWave(const char *fileName);                            
// Load wave from memory buffer, fileType refers to extension: i.e. ".wav"
RLAPI Wave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize); 
// Load sound from file
RLAPI Sound LoadSound(const char *fileName);                          
// Load sound from wave data
RLAPI Sound LoadSoundFromWave(Wave wave);                             
// Update sound buffer with new data
RLAPI void UpdateSound(Sound sound, const void *data, int samplesCount);
// Unload wave data
RLAPI void UnloadWave(Wave wave);                                     
// Unload sound
RLAPI void UnloadSound(Sound sound);                                  
// Export wave data to file, returns true on success
RLAPI bool ExportWave(Wave wave, const char *fileName);               
// Export wave sample data to code (.h), returns true on success
RLAPI bool ExportWaveAsCode(Wave wave, const char *fileName);         

// Wave/Sound management functions
// Play a sound
RLAPI void PlaySound(Sound sound);                                    
// Stop playing a sound
RLAPI void StopSound(Sound sound);                                    
// Pause a sound
RLAPI void PauseSound(Sound sound);                                   
// Resume a paused sound
RLAPI void ResumeSound(Sound sound);                                  
// Play a sound (using multichannel buffer pool)
RLAPI void PlaySoundMulti(Sound sound);                               
// Stop any sound playing (using multichannel buffer pool)
RLAPI void StopSoundMulti(void);                                      
// Get number of sounds playing in the multichannel
RLAPI int GetSoundsPlaying(void);                                     
// Check if a sound is currently playing
RLAPI bool IsSoundPlaying(Sound sound);                               
// Set volume for a sound (1.0 is max level)
RLAPI void SetSoundVolume(Sound sound, float volume);                 
// Set pitch for a sound (1.0 is base level)
RLAPI void SetSoundPitch(Sound sound, float pitch);                   
// Convert wave data to desired format
RLAPI void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels);  
// Copy a wave to a new wave
RLAPI Wave WaveCopy(Wave wave);                                       
// Crop a wave to defined samples range
RLAPI void WaveCrop(Wave *wave, int initSample, int finalSample);     
// Load samples data from wave as a floats array
RLAPI float *LoadWaveSamples(Wave wave);                              
// Unload samples data loaded with LoadWaveSamples()
RLAPI void UnloadWaveSamples(float *samples);                         

// Music management functions
// Load music stream from file
RLAPI Music LoadMusicStream(const char *fileName);                    
// Load music stream from data
RLAPI Music LoadMusicStreamFromMemory(const char *fileType, unsigned char* data, int dataSize); 
// Unload music stream
RLAPI void UnloadMusicStream(Music music);                            
// Start music playing
RLAPI void PlayMusicStream(Music music);                              
// Check if music is playing
RLAPI bool IsMusicPlaying(Music music);                               
// Updates buffers for music streaming
RLAPI void UpdateMusicStream(Music music);                            
// Stop music playing
RLAPI void StopMusicStream(Music music);                              
// Pause music playing
RLAPI void PauseMusicStream(Music music);                             
// Resume playing paused music
RLAPI void ResumeMusicStream(Music music);                            
// Set volume for music (1.0 is max level)
RLAPI void SetMusicVolume(Music music, float volume);                 
// Set pitch for a music (1.0 is base level)
RLAPI void SetMusicPitch(Music music, float pitch);                   
// Get music time length (in seconds)
RLAPI float GetMusicTimeLength(Music music);                          
// Get current music time played (in seconds)
RLAPI float GetMusicTimePlayed(Music music);                          

// AudioStream management functions
// Init audio stream (to stream raw audio pcm data)
RLAPI AudioStream InitAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels); 
// Update audio stream buffers with data
RLAPI void UpdateAudioStream(AudioStream stream, const void *data, int samplesCount); 
// Close audio stream and free memory
RLAPI void CloseAudioStream(AudioStream stream);                      
// Check if any audio stream buffers requires refill
RLAPI bool IsAudioStreamProcessed(AudioStream stream);                
// Play audio stream
RLAPI void PlayAudioStream(AudioStream stream);                       
// Pause audio stream
RLAPI void PauseAudioStream(AudioStream stream);                      
// Resume audio stream
RLAPI void ResumeAudioStream(AudioStream stream);                     
// Check if audio stream is playing
RLAPI bool IsAudioStreamPlaying(AudioStream stream);                  
// Stop audio stream
RLAPI void StopAudioStream(AudioStream stream);                       
// Set volume for audio stream (1.0 is max level)
RLAPI void SetAudioStreamVolume(AudioStream stream, float volume);    
// Set pitch for audio stream (1.0 is base level)
RLAPI void SetAudioStreamPitch(AudioStream stream, float pitch);      
// Default size for new audio streams
RLAPI void SetAudioStreamBufferSizeDefault(int size);                 

#if defined(__cplusplus)
}
#endif

#endif // RAYLIB_H
