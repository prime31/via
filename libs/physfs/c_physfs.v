module physfs

#flag -I @VMOD/via/libs/physfs/thirdparty

#flag darwin -framework IOKit -framework Foundation
#flag darwin @VMOD/via/libs/physfs/thirdparty/macos/libphysfs.a

#flag linux @VMOD/via/libs/physfs/thirdparty/linux/libphysfs.a

#include "physfs.h"

pub const ( version = 1 )