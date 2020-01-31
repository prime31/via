module debug
import via.math
import via.filesystem
import via.libs.sokol.sgl
import via.libs.sokol.sfons

// Note: Debug.draw calls can only be in one pass! If there are calls in multiple passes it will cause sgl
// to attempt to update buffers multiple times in a frame.
struct Debug {
mut:
	fons &C.FONScontext
	def_font int
	did_draw bool
}

const (
	debug = &Debug{}
)

//#region Setup and Lifecycle

pub fn setup() {
	desc := sgl_desc_t{
		max_vertices: 8192
		max_commands: 4096
		pipeline_pool_size: 8
	}
	C.sgl_setup(&desc)

	filesystem.mount('../assets', 'assets', true)

	mut d := debug
	d.fons = sfons.create(128, 128, 1)
	bytes := filesystem.read_bytes_c(c'assets/ProggyTiny.ttf')
	d.def_font = C.fonsAddFontMem(d.fons, 'sans', bytes.data, bytes.len, false)
	d.fons.set_size(10)
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
	C.sgl_v2f(x, y - 1)
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

pub fn draw_text(x, y f32, text string) {
	debug.fons.draw_text(x, y, text.str, byteptr(0))
}

//#endregion