MODULE_FOLDER := thirdparty
$(shell mkdir -p $(MODULE_FOLDER))

TARGET = build
TARGET += copy_static

##---------------------------------------------------------------------
## BUILD FLAGS PER PLATFORM
##---------------------------------------------------------------------
UNAME_S := $(shell uname -s)
LIB_FOLDER :=

ifeq ($(UNAME_S), Linux)
	SED := sed -i
	TARGET += copy_linux_shared
	TARGET += cross_compile_win
	LIB_FOLDER = linux
else ifeq ($(UNAME_S), Darwin)
	SED := sed -i ''
	TARGET += copy_mac_shared
	LIB_FOLDER = macos
endif

TARGET += patch_flecs_bool
TARGET += clean


all: $(TARGET)

# fix flecs typedef since v has its own to int already
patch_flecs_bool:
ifdef SED
	$(SED) "s/typedef char bool;/\/\/typedef char bool;/g" $(MODULE_FOLDER)/include/flecs.h
endif

copy_static:
	cp flecs_git/build/libflecs_static.a $(MODULE_FOLDER)/$(LIB_FOLDER)
	rsync -rupE flecs_git/include $(MODULE_FOLDER)

copy_mac_shared:
	# fix the @rpath
	install_name_tool -id @rpath/libflecs_shared.dylib flecs_git/build/libflecs_shared.dylib
	cp flecs_git/build/libflecs_shared.dylib $(MODULE_FOLDER)/$(LIB_FOLDER)

copy_linux_shared:
	cp flecs_git/build/libflecs_shared.so $(MODULE_FOLDER)/$(LIB_FOLDER)

build:
	[ -d flecs_git ] || git clone --depth 1 https://github.com/SanderMertens/flecs flecs_git
	(cd flecs_git ; mkdir build ; cd build ; cmake .. ; make)
	[ -d $(MODULE_FOLDER)/$(LIB_FOLDER) ] || mkdir $(MODULE_FOLDER)/$(LIB_FOLDER)

build-wasm:
	[ -d flecs_git ] || git clone --depth 1 https://github.com/SanderMertens/flecs flecs_git
	(cd flecs_git ; mkdir build ; cd build ; emconfigure cmake .. ; emconfigure make)
	[ -d $(MODULE_FOLDER)/webgl ] || mkdir $(MODULE_FOLDER)/webgl
	cp flecs_git/build/libflecs_static.a $(MODULE_FOLDER)/webgl

cross_compile_win:
	(cd flecs_git ; rm -rf build ; mkdir build ; cd build ; cmake $(OPTS) -DCMAKE_TOOLCHAIN_FILE=../../../../via/libs/win_build/mingw-w64-x86_64.cmake .. ; make)
	[ -d $(MODULE_FOLDER)/win64 ] || mkdir $(MODULE_FOLDER)/win64
	cp flecs_git/build/libflecs_shared.dll $(MODULE_FOLDER)/win64
	cp flecs_git/build/libflecs_static.a $(MODULE_FOLDER)/win64

clean:
	rm -rf flecs_git
