module physfs

#flag -I @VROOT/libs/physfs/thirdparty

#flag darwin -framework IOKit -framework Foundation
#flag darwin @VROOT/libs/physfs/thirdparty/macos/libphysfs.a

#flag linux @VROOT/libs/physfs/thirdparty/linux/libphysfs.a

#include "physfs.h"

pub const ( version = 1 )