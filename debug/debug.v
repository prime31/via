module debug
import via.math
import via.filesystem
import via.libs.fontstash
import via.libs.sokol.sgl
import via.libs.sokol.sfons

pub const ( used_import = sgl.used_import )

// Note: Debug.draw calls can only be in one pass! If there are calls in multiple passes it will cause sgl
// to attempt to update buffers multiple times in a frame.
struct Debug {
mut:
	fons &C.FONScontext
	def_font int
	did_draw bool
}

const (
	debug = &Debug{
		fons: 0
	}
)

pub struct TextConfig {
	color math.Color = math.Color{}
	scale f32 = 1.0
	align fontstash.FonsAlign = fontstash.FonsAlign.default
}

//#region Setup and Lifecycle

pub fn setup() {
	desc := sgl_desc_t{}
	C.sgl_setup(&desc)

	mut d := debug
	d.fons = sfons.create(128, 128, 1)
	if filesystem.exists_c(c'assets/ProggyTiny.ttf') {
		bytes := filesystem.read_bytes_c(c'assets/ProggyTiny.ttf')
		d.def_font = C.fonsAddFontMem(d.fons, 'ProggyTiny', bytes.data, bytes.len, false)
		d.fons.set_size(10)
	} else {
		println('could not find assets/ProggyTiny.ttf. debug.draw_text will not work until a font is loaded.')
	}
}

pub fn begin(w, h int) {
	mut d := debug
	d.did_draw = false

	C.sgl_defaults()
	C.sgl_matrix_mode_projection()

	mat := math.mat32_ortho_off_center(w, h)
	set_proj_mat(mat)
}

pub fn set_proj_mat(mat math.Mat32) {
	C.sgl_matrix_mode_projection()
	C.sgl_load_matrix(mat.to_mat44().data)
}

// directly multiplies the current matrix by mat
pub fn mult_mat(mat math.Mat32) {
	C.sgl_mult_matrix(mat.to_mat44().data)
}

// commits the frame and renders all commands
pub fn draw() {
	// only draw once per frame
	if debug.did_draw { return }
	mut d := debug
	d.did_draw = true

	sfons.flush(debug.fons)
	C.sgl_draw()
}

pub fn shutdown() {
	C.sgl_shutdown()
}

//#endregion

//#region State Management

pub fn set_color(color math.Color) {
	C.sgl_c4b(color.r(), color.g(), color.b(), color.a())
}

pub fn reset_color() {
	C.sgl_c4b(255, 255, 255, 255)
}

pub fn set_font_size(size int) {
	debug.fons.set_size(size)
}

pub fn matrix_mode_modelview() {
	C.sgl_matrix_mode_modelview()
}

pub fn load_identity() {
	C.sgl_load_identity()
}

pub fn translate(x, y f32) {
	C.sgl_translate(x, y, 1)
}

pub fn scale(x, y f32) {
	C.sgl_scale(x, y, 1.0)
}

pub fn rotate(angle_rad f32, x f32, y f32, z f32) {
	C.sgl_rotate(angle_rad, x, y, z)
}

pub fn rotate_z(angle_rad f32) {
	rotate(angle_rad, 0, 0, 1)
}

pub fn push_matrix() {
	C.sgl_push_matrix()
}

pub fn pop_matrix() {
	C.sgl_pop_matrix()
}

//#endregion

//#region Drawing

pub fn draw_line(x1, y1, x2, y2 f32) {
	C.sgl_begin_line_strip()
	C.sgl_v2f(x1, y1)
	C.sgl_v2f(x2, y2)
	C.sgl_end()
}

pub fn draw_hollow_rect(x, y, w, h f32) {
	C.sgl_begin_line_strip()
	C.sgl_v2f(x, y)
	C.sgl_v2f(x + w, y)
	C.sgl_v2f(x + w, y + h)
	C.sgl_v2f(x, y + h)
	C.sgl_v2f(x, y)
	C.sgl_end()
}

pub fn draw_filled_rect(x, y, w, h f32) {
	C.sgl_begin_quads()
	C.sgl_v2f(x, y)
	C.sgl_v2f(x + w, y)
	C.sgl_v2f(x + w, y + h)
	C.sgl_v2f(x, y + h)
	C.sgl_end()
}

pub fn draw_text(x, y f32, text string, config TextConfig) {
	debug.fons.set_color(config.color.value)
	debug.fons.set_align(config.align)

	matrix_mode_modelview()
	push_matrix()
	translate(x, y)
	scale(config.scale, config.scale)
	debug.fons.draw_text(0, 0, text.str, byteptr(0))
	pop_matrix()
}

//#endregion

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