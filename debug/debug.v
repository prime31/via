module debug
import via.fonts
import via.graphics

#flag -I @VMOD/via/debug/thirdparty
#include "proggytiny.h"

struct Debug {
mut:
	fontbook &fonts.FontBook
	def_font int
}

const (
	debug = &Debug{
		fontbook: 0
	}
)

pub fn get_fontbook() &fonts.FontBook {
	if debug.fontbook == 0 {
		mut d := debug
		d.fontbook = graphics.new_fontbook(128, 128)
		d.def_font = d.fontbook.add_font_memory('ProggyTiny', C.ProggyTiny_ttf, C.ProggyTiny_ttf_len, false)
		d.fontbook.set_size(10)
	}
	return debug.fontbook
}

//#region Logging

pub fn info(msg string) {
	print('\x1b[100m \x1b[49m ')
	println(msg)
}

pub fn log(msg string) {
	print('\x1b[42m \x1b[49m ')
	println(msg)
}

pub fn warn(msg string) {
	print('\x1b[43m \x1b[49m ')
	println(msg)
}

pub fn error(msg string) {
	print('\x1b[41m \x1b[49m ')
	println(msg)
}

//#endregion