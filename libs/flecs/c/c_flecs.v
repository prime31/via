module c

#flag -I @VMOD/via/libs/flecs/thirdparty
#flag -I @VMOD/via/libs/flecs/thirdparty/include
#flag -I @VMOD/via/libs/flecs/thirdparty/include/util

// both static and shared will work for macos
// ----- static config -----
// #flag darwin @VMOD/via/libs/flecs/thirdparty/macos/libflecs_static.a
// ----- shared config -----
#flag darwin -rpath @VMOD/via/libs/flecs/thirdparty/macos
#flag darwin -L @VMOD/via/libs/flecs/thirdparty/macos
#flag darwin -lflecs_shared

// shared requres setting rpath
#flag linux @VMOD/via/libs/flecs/thirdparty/linux/libflecs_static.a
//#flag linux -L @VMOD/via/libs/flecs/thirdparty/linux
//#flag linux -lflecs_shared
//#flag linux '-Wl,-rpath,@VMOD/via/libs/flecs/thirdparty/linux'

#include "include/flecs.h"


pub const ( version = 1 )

