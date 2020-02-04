module c

#flag -I @VMOD/via/libs/flecs/thirdparty
#flag -I @VMOD/via/libs/flecs/thirdparty/include
#flag -I @VMOD/via/libs/flecs/thirdparty/include/util
#flag -L @VMOD/via/libs/flecs/thirdparty

// both static and shared will work for macos
#flag darwin @VMOD/via/libs/flecs/thirdparty/macos/libflecs_static.a
//#flag darwin -lflecs_shared

// shared requres setting rpath
#flag linux @VMOD/via/libs/flecs/thirdparty/linux/libflecs_static.a
//#flag linux -lflecs_shared
//#flag linux '-Wl,-rpath,@VMOD/via/libs/flecs/thirdparty/linux'

#include "include/flecs.h"


pub const ( version = 1 )

