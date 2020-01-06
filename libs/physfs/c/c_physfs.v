module c

#flag -I @VMOD/via/libs/physfs/thirdparty

#flag darwin -framework IOKit -framework Foundation
#flag darwin @VMOD/via/libs/physfs/thirdparty/libphysfs.a

#flag linux @VMOD/via/libs/physfs/thirdparty/libphysfs.a

#include "physfs.h"

pub const ( version = 1 )