module sokol

pub const ( used_import = 0 )

#flag -I @VROOT/libs/sokol/thirdparty
#flag -I @VROOT/libs/sokol/thirdparty/util

#flag linux -lX11 -lGL

// METAL: must be run with "v -d metal"
// #flag -DSOKOL_METAL
// #flag darwin -framework Metal -framework Cocoa -framework MetalKit -framework QuartzCore -fobjc-arc

// OPENGL
#flag -DSOKOL_GLCORE33
#flag darwin -framework OpenGL -framework Cocoa -framework QuartzCore
// this is just to quite the warnings about gl.h and gl3.h being included by Apple
// #flag darwin -DGL_DO_NOT_WARN_IF_MULTI_GL_VERSION_HEADERS_INCLUDED


#define SOKOL_IMPL
#define SOKOL_NO_DEPRECATED
#include "sokol_gfx.h"