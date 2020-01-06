module sokol

#flag -I @VMOD/via/sokol/thirdparty
#flag -I @VMOD/via/sokol/thirdparty/util

#flag darwin -fobjc-arc
#flag linux -lX11 -lGL

// METAL
// #define SOKOL_METAL // which one? depends on import order...
// #flag -DSOKOL_METAL
// #flag darwin -framework Metal -framework Cocoa -framework MetalKit -framework QuartzCore

// OPENGL
// #define SOKOL_GLCORE33 // which one? depends on import order...
#flag -DSOKOL_GLCORE33
#flag darwin -framework OpenGL -framework Cocoa -framework QuartzCore
// this is just to quite the warnings about gl.h and gl3.h being included by Apple
// #flag darwin -DGL_DO_NOT_WARN_IF_MULTI_GL_VERSION_HEADERS_INCLUDED



// this ensures app gets included before gfx. For SDL we dont need app but we dont have top-level
// $ifs yet so we deal with importing it anyway
// #define SOKOL_IMPL
// #define SOKOL_NO_ENTRY
// #include "sokol_app.h"


// for the gfx_helper, as long as we need it for setting subimage[x][y]
#flag -I @VMOD/via/sokol/gfx

#define SOKOL_IMPL
#define SOKOL_NO_DEPRECATED
#include "sokol_gfx.h"
#include "gfx_helper.h"