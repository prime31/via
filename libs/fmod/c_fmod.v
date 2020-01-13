module fmod
import via.libs.fmod.core.c as c_core
import via.libs.fmod.studio.c as c_studio

#flag -I @VMOD/via/libs/fmod/thirdparty/core
#flag -I @VMOD/via/libs/fmod/thirdparty/studio

#flag darwin -L @VMOD/via/libs/fmod/thirdparty/macos -lfmod -lfmodstudio
#flag darwin -rpath @VMOD/via/libs/fmod/thirdparty/macos

#flag linux -L @VMOD/via/libs/fmod/thirdparty/linux
#flag linux -Wl,-rpath,@VMOD/via/libs/fmod/thirdparty/linux
#flag linux -lfmod -lfmodstudio

#include "fmod.h"
#include "fmod_studio.h"
#include "fmod_errors.h"


pub const (
	version = 1
)


fn C.FMOD_ErrorString(errcode int) byteptr

pub fn error_string(errcode int) string {
	return tos2(FMOD_ErrorString(errcode))
}