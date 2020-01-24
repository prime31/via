CFLAGS := -I thirdparty
CFLAGS += `sdl2-config --cflags`

MODULE_FOLDER := thirdparty
$(shell mkdir -p $(MODULE_FOLDER))


all:
	[ -d $(MODULE_FOLDER)/webgl ] || mkdir $(MODULE_FOLDER)/webgl
	emcc -Wall -Wextra -s WASM=1 thirdparty/flextGL.c -o $(MODULE_FOLDER)/webgl/flextGL.bc
	#cp physfs_hg/build/libphysfs.a $(MODULE_FOLDER)/webgl

