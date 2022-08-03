module fmod
import via.libs.fmod.core.c as c_core

pub const ( used_import = c_core.used_import )

#flag -I @VROOT/libs/fmod/thirdparty/core

#flag darwin -L @VROOT/libs/fmod/thirdparty/macos -lfmod
#flag darwin -rpath @VROOT/libs/fmod/thirdparty/macos

#flag linux -L @VROOT/libs/fmod/thirdparty/linux
#flag linux -Wl,-rpath,@VROOT/libs/fmod/thirdparty/linux
#flag linux -lfmod

#include "fmod.h"
#include "fmod_errors.h"



fn C.FMOD_ErrorString(errcode int) byteptr

pub fn error_string(errcode int) string {
	return tos2(C.FMOD_ErrorString(errcode))
}