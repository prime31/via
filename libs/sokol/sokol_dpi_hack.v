module sokol

#include "sokol_sdl_dpi.h"

// this method should be called if a non high-dpi window was requested. It should be called _after_
// the SDL window is created.
fn C.sokol_sdl_fix_low_dpi()