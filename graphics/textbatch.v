module graphics
import via.math
import via.utils
import via.fonts
import via.libs.sokol.gfx

pub const ( tb_import = gfx.used_import )

pub struct TextBatch {
mut:
	bindings C.sg_bindings
	verts []math.Vertex
	max_chars int
	char_cnt int = 0
	last_appended_char_cnt int = 0
	img C.sg_image
	quad math.Quad
}

pub fn textbatch(max_chars int) &TextBatch {

	//arr := utils.new_arr_with_default<math.Vertex>(max_chars * 4, max_chars * 4, math.Vertex{})
	arr := []math.Vertex{len: max_chars * 4, cap: max_chars * 4, init: math.Vertex{}}

	mut tb := &TextBatch{
		// default colors to white
		verts: arr
		max_chars: max_chars
		quad: math.quad(0, 0, 1, 1, 1, 1)
	}

	indices := new_vert_quad_index_buffer(max_chars)
	tb.bindings = bindings_create(tb.verts, .stream, indices, .immutable)
	unsafe { indices.free() }

	return tb
}

fn (tb &TextBatch) ensure_capacity(chars int) bool {
	if tb.char_cnt + chars > tb.max_chars {
		println('Error: textbatch full. Aborting draw.')
		return false
	}
	return true
}

pub fn (tbb &TextBatch) end() {
	mut tb := tbb
	tb.flush()
	tb.last_appended_char_cnt = 0
	tb.char_cnt = 0
	tb.img.id = 0
}

fn (mut tb TextBatch) draw_q_m(quad &math.Quad, matrix &math.Mat32, color &math.Color) {
	base_vert := tb.char_cnt * 4
	tb.char_cnt++
	matrix.transform_vec2_arr(&tb.verts[base_vert], &quad.positions[0], 4)

	for i in 0..4 {
		tb.verts[base_vert + i].s = quad.texcoords[i].x
		tb.verts[base_vert + i].t = quad.texcoords[i].y
		tb.verts[base_vert + i].color = *color
	}
}

pub fn (mut tb TextBatch) draw_text(font &fonts.FontBook, str string, config DrawConfig) {
	if !tb.ensure_capacity(str.len) { return }
	if tb.img.id != font.img.id {
		tb.flush()
		tb.bindings.set_frag_image(0, font.img)
		tb.img = font.img
	}

	matrix := config.get_matrix()

	mut f := font
	f.update_texture()
	iter := C.FONStextIter{}
	C.fonsTextIterInit(font.stash, &iter, 0, 0, str.str, C.NULL)

	fons_quad := C.FONSquad{}
	mut iter_result := 1
	for iter_result == 1 {
		iter_result = C.fonsTextIterNext(font.stash, &iter, &fons_quad)

		// TODO: maybe make the transform_vec2_arr generic and just use a local fixed array for positions and tex coords?
		tb.quad.positions[0] = math.Vec2{fons_quad.x0, fons_quad.y0}
		tb.quad.positions[1] = math.Vec2{fons_quad.x1, fons_quad.y0}
		tb.quad.positions[2] = math.Vec2{fons_quad.x1, fons_quad.y1}
		tb.quad.positions[3] = math.Vec2{fons_quad.x0, fons_quad.y1}

		tb.quad.texcoords[0] = math.Vec2{fons_quad.s0, fons_quad.t0}
		tb.quad.texcoords[1] = math.Vec2{fons_quad.s1, fons_quad.t0}
		tb.quad.texcoords[2] = math.Vec2{fons_quad.s1, fons_quad.t1}
		tb.quad.texcoords[3] = math.Vec2{fons_quad.s0, fons_quad.t1}
		tb.draw_q_m(tb.quad, matrix, config.color)
	}
}

pub fn (mut tb TextBatch) flush() {
	total_quads := (tb.char_cnt - tb.last_appended_char_cnt)
	if total_quads == 0 { return }

	total_verts := total_quads * 4
	tb.bindings.vertex_buffer_offsets[0] = C.sg_append_buffer(tb.bindings.vertex_buffers[0], &tb.verts[tb.last_appended_char_cnt * 4], sizeof(math.Vertex) * u32(total_verts))
	tb.last_appended_char_cnt = tb.char_cnt

	C.sg_apply_bindings(&tb.bindings)
	C.sg_draw(0, total_quads * 6, 1)
}

pub fn (tb &TextBatch) free() {
	tb.bindings.vertex_buffers[0].free()
	tb.bindings.index_buffer.free()

	unsafe {
		tb.verts.free()
		C.free(tb)
	}
}