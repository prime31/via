module c

#flag -I @VROOT/libs/flecs/thirdparty
#flag -I @VROOT/libs/flecs/thirdparty/include
#flag -I @VROOT/libs/flecs/thirdparty/include/util

// both static and shared will work for macos
// ----- static config -----
// #flag darwin @VROOT/libs/flecs/thirdparty/macos/libflecs_static.a
// ----- shared config -----
#flag darwin -rpath @VROOT/libs/flecs/thirdparty/macos
#flag darwin -L @VROOT/libs/flecs/thirdparty/macos
#flag darwin -lflecs_shared

// shared requres setting rpath
#flag linux @VROOT/libs/flecs/thirdparty/linux/libflecs_static.a
//#flag linux -L @VROOT/libs/flecs/thirdparty/linux
//#flag linux -lflecs_shared
//#flag linux '-Wl,-rpath,@VROOT/libs/flecs/thirdparty/linux'

#include "include/flecs.h"


pub const ( version = 1 )

