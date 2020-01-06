module c

// if we are using Flextgl we need to set this flag! ImGui defaults to gl3w
#flag -DIMGUI_IMPL_OPENGL_LOADER_CUSTOM
#flag -DCIMGUI_DEFINE_ENUMS_AND_STRUCTS=1
#flag -DIMGUI_DISABLE_OBSOLETE_FUNCTIONS=1
#flag -DIMGUI_IMPL_API=

#flag -I @VMOD/via/libs/imgui

#flag linux @VMOD/via/libs/imgui/thirdparty/cimgui.a
#flag linux -lGL -lstdc++

#flag @VMOD/via/libs/imgui/thirdparty/imgui_impl_sdl.o
#flag @VMOD/via/libs/imgui/thirdparty/imgui_impl_opengl3.o

// both static and shared will work. if you use dynamic uncomment both lines below and comment this one out
#flag darwin @VMOD/via/libs/imgui/thirdparty/cimgui.a

// rpath is required for shared. for proper installs, -rpath should be relative to @executable_path/
// #flag darwin -rpath @VMOD/via/libs/imgui/thirdparty
// #flag darwin @VMOD/via/libs/imgui/thirdparty/cimgui.dylib

#flag darwin -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo `sdl2-config --libs`
#flag darwin -lm -lc++

#include "thirdparty/cimgui.h"
#include "thirdparty/imgui_impl_opengl3.h"
#include "thirdparty/imgui_impl_sdl.h"