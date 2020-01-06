TARGET :=

#CP := cp
MODULE_FOLDER := thirdparty/cimgui
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

# use can either a dylib or static lib, so we will generate both and let the c_imgui.v file decide
TARGET += cimgui.a

##---------------------------------------------------------------------
## BUILD FLAGS PER PLATFORM
##---------------------------------------------------------------------
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	LIBS += -ldl # necessary?
	#TARGET += cimgui.so not yet supported
else ifeq ($(UNAME_S), Darwin)
	TARGET += cimgui.dylib
endif



##---------------------------------------------------------------------
## BUILD RULES
##---------------------------------------------------------------------

all: $(TARGET)
	@echo build complete

cimgui.dylib: cimgui_git/build/cimgui.dylib
	cp cimgui_git/cimgui.h $(MODULE_FOLDER)/cimgui.h
	cp cimgui_git/build/cimgui.dylib $(MODULE_FOLDER)/cimgui.dylib

cimgui_git/build/cimgui.dylib:
	[ -d cimgui_git ] || git clone --recursive --depth 1 $(IMGUI_BRANCH) https://github.com/cimgui/cimgui.git cimgui_git
	(export CFLAGS= CXXFLAGS= ; cd cimgui_git ; mkdir build ; cd build ; cmake -DIMGUI_STATIC=OFF .. ; make)

cimgui.a: cimgui_git/build/cimgui.a
	cp cimgui_git/cimgui.h $(MODULE_FOLDER)/cimgui.h
	cp cimgui_git/build/cimgui.a $(MODULE_FOLDER)/cimgui.a

cimgui_git/build/cimgui.a:
	[ -d cimgui_git ] || git clone --recursive --depth 1 $(IMGUI_BRANCH) https://github.com/cimgui/cimgui.git cimgui_git
	(export CFLAGS= CXXFLAGS= ; cd cimgui_git ; mkdir build ; cd build ; cmake -DIMGUI_STATIC=ON .. ; make)

generate_v_bindings:
	#dotnet run --project generator

clean:
	$(RM) *.o *.so *.h $(TARGET)

clobber: clean
	#$(RM) -Rf cimgui_git
