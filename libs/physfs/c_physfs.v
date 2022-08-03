module physfs

#flag -I @VROOT/libs/physfs/thirdparty

#flag darwin -framework IOKit -framework Foundation
#flag darwin @VROOT/libs/physfs/thirdparty/macos/libphysfs.a

//#flag linux @VROOT/libs/physfs/thirdparty/linux/libphysfs.a
#flag linux -L @VROOT/libs/physfs/thirdparty/linux
#flag linux -l physfs

#include "physfs.h"

pub const ( version = 1 )
