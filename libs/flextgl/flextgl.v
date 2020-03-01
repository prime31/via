module flextgl

pub const ( used_import = 0 )

#flag darwin -framework OpenGL -framework Cocoa -framework QuartzCore

#flag -I @VROOT/libs/flextgl/thirdparty
#flag @VROOT/libs/flextgl/thirdparty/flextGL.o
#include "flextGL.h"

fn C.flextInit() int

pub fn flext_init() int {
	return C.flextInit()
}