module flextgl

pub const ( used_import = 0 )

#flag darwin -framework OpenGL -framework Cocoa -framework QuartzCore

#flag -I @VMOD/via/libs/flextgl/thirdparty
#flag @VMOD/via/libs/flextgl/thirdparty/flextGL.o
#include "flextGL.h"

fn C.flextInit() int

pub fn flext_init() int {
	return C.flextInit()
}