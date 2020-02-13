module graphics
import via.math
import via.fonts
import via.libs.fontstash

// #flag -I @VMOD/via/debug/thirdparty
// #include "proggytiny.h"

// pub const ( used_import = sgl.used_import )

struct Debug {
mut:
	fontbook &fonts.FontBook
	def_font int
	proj_mat math.Mat32
}

const (
	debug = &Debug{
		fontbook: 0
	}
)

pub struct TextConfig {
	color math.Color = math.Color{}
	scale f32 = 1.0
	align fontstash.FonsAlign = fontstash.FonsAlign.default
}

//#region Setup and Lifecycle

pub fn debug_setup() {
	mut d := debug
	d.fontbook = new_fontbook(128, 128)
	d.def_font = d.fontbook.add_font_memory('ProggyTiny', C.ProggyTiny_ttf, C.ProggyTiny_ttf_len, false)
	d.fontbook.set_size(10)
}

fn debug_set_proj_mat(mat math.Mat32) {
	mut d := debug
	d.proj_mat = mat
}

// commits the frame and renders all commands
fn debug_draw() {

}

//#endregion

//#region Drawing

pub fn debug_draw_line(x1, y1, x2, y2, thickness f32, color math.Color) {
	mut batch := tribatch()
	batch.draw_line(x1, y1, x2, y2, thickness, color)
}

pub fn debug_draw_hollow_rect(x, y, width, height, thickness f32, color math.Color) {
	mut batch := tribatch()
	batch.draw_hollow_rect(x, y, width, height, thickness, color)
}

pub fn debug_draw_filled_rect(w, h f32, config DrawConfig) {
	mut batch := tribatch()
	batch.draw_rectangle(w, h, config)
}

pub fn debug_draw_text(text string, config DrawConfig) {
	mut batch := spritebatch()
	batch.draw_text(debug.fontbook, text, config)
}

//#endregion

//#region Logging

// pub fn info(msg string) {
// 	print('\x1b[100m \x1b[49m ')
// 	println(msg)
// }

// pub fn log(msg string) {
// 	print('\x1b[42m \x1b[49m ')
// 	println(msg)
// }

// pub fn warn(msg string) {
// 	print('\x1b[43m \x1b[49m ')
// 	println(msg)
// }

// pub fn error(msg string) {
// 	print('\x1b[41m \x1b[49m ')
// 	println(msg)
// }

//#endregion