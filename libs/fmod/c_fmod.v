module fmod
import via.libs.fmod.core.c as c_core
import via.libs.fmod.studio.c as c_studio

pub const ( used_import = c_core.used_import + c_studio.used_import )

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



fn C.FMOD_ErrorString(errcode int) byteptr

pub fn error_string(errcode int) string {
	return tos2(FMOD_ErrorString(errcode))
}