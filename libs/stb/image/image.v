module image

#flag -I @VROOT/libs/stb/image/thirdparty
#flag @VROOT/libs/stb/image/thirdparty/stb_image.o

#include "stb_image.h"


pub enum Channels {
	default int = 0
	grey int = 1
	grey_alpha int = 2
	rgb int = 3
	rgb_alpha int = 4
}

pub struct Image {
pub mut:
	width int
	height int
	channels Channels
	data voidptr
}

pub fn (i Image) str() string { return 'w=$i.width, h=$i.height, channels=$i.channels' }

pub fn (img Image) free() { C.stbi_image_free(img.data) }


fn C.stbi_load(filename byteptr, x &int, y &int, channels_in_file &int, desired_channels int) voidptr
fn C.stbi_load_from_memory(buffer &byte, len int, x &int, y &int, channels_in_file &int, desired_channels int) voidptr

fn C.stbi_image_free(retval_from_stbi_load voidptr)

fn C.stbi_info(filename byteptr, x &int, y &int, comp &int) int
fn C.stbi_info_from_memory(buffer &byte, len int, x &int, y &int, comp &int) int

fn C.stbi_set_flip_vertically_on_load(flag_true_if_should_flip int)
fn C.stbi_failure_reason() byteptr


pub fn set_flip_vertically_on_load(val bool) {
	C.stbi_set_flip_vertically_on_load(val)
}

pub fn load(path string) Image { return load_channels(path, .default) }

pub fn load_channels(path string, channels Channels) Image {
	mut img := Image{data: 0}

	img.data = C.stbi_load(path.str, &img.width, &img.height, &img.channels, int(channels))
	if isnil(img.data) {
		println('stbi image failed to load: ${C.stbi_failure_reason()}')
		exit(1)
	}
	return img
}

pub fn get_info(filename string) (int, int, int) {
	w := 0
	h := 0
	comp := 0
	C.stbi_info(filename.str, &w, &h, &comp)
	return w, h, comp
}

pub fn load_from_memory(buffer voidptr, len int) Image { return load_channels_from_memory(buffer, len, .rgb_alpha) }

pub fn load_channels_from_memory(buffer voidptr, len int, channels Channels) Image {
	mut img := Image{data: 0}

	img.data = C.stbi_load_from_memory(buffer, len, &img.width, &img.height, &img.channels, int(channels))
	if isnil(img.data) {
		panic('failed to load image')
	}
	return img
}

pub fn get_info_from_memory(buffer voidptr, len int) (int, int, int) {
	w := 0
	h := 0
	comp := 0
	C.stbi_info_from_memory(buffer, len, &w, &h, &comp)
	return w, h, comp
}