GL_LOADER_FLEXT := 1

TARGET :=

CP := cp
MODULE_FOLDER := thirdparty
$(shell mkdir -p $(MODULE_FOLDER))
CIMGUI := cimgui_git
IMGUI := $(CIMGUI)/imgui

# might as well use docking branch since its stable now
IMGUI_BRANCH := --single-branch --branch docking

LIBS :=

CFLAGS := -I.
CFLAGS += -DCIMGUI_DEFINE_ENUMS_AND_STRUCTS=1
CFLAGS += -DIMGUI_DISABLE_OBSOLETE_FUNCTIONS=1
CFLAGS += -DIMGUI_IMPL_API=
CFLAGS += `sdl2-config --cflags`


##---------------------------------------------------------------------
## OPEN GL FUNCTION LOADER
##---------------------------------------------------------------------

MESSAGE :=
ifeq ($(GL_LOADER_FLEXT), 1)
	# Using OpenGL loader for FlextGL
	CFLAGS += -I ../flextgl/thirdparty
	CFLAGS += -DIMGUI_IMPL_OPENGL_LOADER_CUSTOM=\"flextGL.h\"
	MESSAGE += using GL loader FlextGL
else
	# Using OpenGL loader gl3w. Depending on the Makefile for gl3w (it can build using imgui's libs/gl3w
	# or from gl3w directly) we will require a different header inclusion here
	# CFLAGS += -I cimgui_git/imgui/examples/libs/gl3w
	CFLAGS += -I ../gl3w/thirdparty
	CFLAGS += -DIMGUI_IMPL_OPENGL_LOADER_GL3W
	MESSAGE += using GL loader gl3w
endif


# use can either a dylib or static lib, so we will generate both and let the c_imgui.v file decide
TARGET += cimgui.a
TARGET += imgui_impl_sdl.o
TARGET += imgui_impl_opengl3.o

##---------------------------------------------------------------------
## BUILD FLAGS PER PLATFORM
##---------------------------------------------------------------------
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux) #LINUX
	LIBS += -lGL -ldl `sdl2-config --libs`
	CFLAGS += `sdl2-config --cflags`

	SED := sed -i
	#TARGET += cimgui.so not yet supported
else ifeq ($(UNAME_S), Darwin) #APPLE
	LIBS += -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo `sdl2-config --libs`
	LIBS += -L/usr/local/lib

	CFLAGS += `sdl2-config --cflags`
	CFLAGS += -I/usr/local/include

	SED := sed -i ''
	TARGET += cimgui.dylib
endif



##---------------------------------------------------------------------
## BUILD RULES
##---------------------------------------------------------------------

all: $(TARGET)
	$(info $(MESSAGE))
	@echo build complete

cimgui.dylib: cimgui_git/build/cimgui.dylib
	$(CP) cimgui_git/cimgui.h $(MODULE_FOLDER)/cimgui.h
	$(CP) cimgui_git/build/cimgui.dylib $(MODULE_FOLDER)/cimgui.dylib

cimgui_git/build/cimgui.dylib:
	[ -d cimgui_git ] || git clone --recursive --depth 1 $(IMGUI_BRANCH) https://github.com/cimgui/cimgui.git cimgui_git
	(export CFLAGS= CXXFLAGS= ; cd cimgui_git ; mkdir build ; cd build ; cmake -DIMGUI_STATIC=OFF .. ; make)

cimgui.a: cimgui_git/build/cimgui.a
	$(CP) cimgui_git/cimgui.h $(MODULE_FOLDER)/cimgui.h
	$(CP) cimgui_git/build/cimgui.a $(MODULE_FOLDER)/cimgui.a

cimgui_git/build/cimgui.a:
	[ -d cimgui_git ] || git clone --recursive --depth 1 $(IMGUI_BRANCH) https://github.com/cimgui/cimgui.git cimgui_git
	(export CFLAGS= CXXFLAGS= ; cd cimgui_git ; mkdir build ; cd build ; cmake -DIMGUI_STATIC=ON .. ; make)

imgui_impl_sdl.o: $(IMGUI)/examples/imgui_impl_sdl.cpp
	$(CXX) -fPIC -c -o $(MODULE_FOLDER)/$@ $^ -I$(IMGUI) `sdl2-config --cflags` -DIMGUI_IMPL_API=extern\ \"C\" -fno-threadsafe-statics
	$(CP) $(IMGUI)/examples/imgui_impl_sdl.h $(MODULE_FOLDER)/imgui_impl_sdl.h
ifdef SED
	$(SED) "s/(SDL_Window/(struct SDL_Window/g" $(MODULE_FOLDER)/imgui_impl_sdl.h
endif

imgui_impl_opengl3.o: $(IMGUI)/examples/imgui_impl_opengl3.cpp
	$(CXX) -fPIC -c -o $(MODULE_FOLDER)/$@ $^ -I$(IMGUI) $(CFLAGS) $(LIBS) -DIMGUI_IMPL_API=extern\ \"C\" -fno-threadsafe-statics
	$(CP) $(IMGUI)/examples/imgui_impl_opengl3.h $(MODULE_FOLDER)/imgui_impl_opengl3.h
ifdef SED
	$(SED) "s/glsl_version = NULL/glsl_version/g" $(MODULE_FOLDER)/imgui_impl_opengl3.h
endif

generate_v_bindings:
	dotnet run --project generator

clean:
	$(RM) *.o *.so *.h $(TARGET)

clobber: clean
	$(RM) -Rf cimgui_git
