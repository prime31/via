module sfons
import via.libs.sokol.sgl
import via.libs.fontstash

#flag -I @VMOD/via/libs/fontstash/thirdparty

// this doesnt quite work due to sokol import order stuff and we have it imported elsewhere
// #include "fontstash.h"
#define SOKOL_FONTSTASH_IMPL
#include "util/sokol_fontstash.h"

[inline]
pub fn create(width int, height int, flags int) &C.FONScontext {
	return C.sfons_create(width, height, flags)
}

[inline]
pub fn destroy(ctx &C.FONScontext) {
	C.sfons_destroy(ctx)
}

[inline]
pub fn rgba(r byte, g byte, b byte, a byte) u32 {
	return C.sfons_rgba(r, g, b, a)
}

[inline]
pub fn flush(ctx &C.FONScontext) {
	C.sfons_flush(ctx)
}

