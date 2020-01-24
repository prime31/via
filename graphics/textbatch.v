module graphics
import via.math
import via.utils
import via.fonts
import via.libs.sokol.gfx

pub struct TextBatch {
mut:
	bindings sg_bindings
	verts []math.Vertex
	max_chars int
	char_cnt int = 0
	last_appended_char_cnt int = 0
	img C.sg_image
	quad math.Quad
	trans_mat math.Mat44
	uniform_set bool
}

pub fn textbatch(max_chars int) &TextBatch {
	mut tb := &TextBatch{
		// default colors to white
		verts: utils.new_arr_with_default(max_chars * 4, max_chars * 4, math.Vertex{})
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
		println('Error: textbatch full. Aborting daw.')
		return false
	}
	return true
}

pub fn (tb mut TextBatch) begin(trans_mat math.Mat44) {
	tb.trans_mat = trans_mat
	tb.uniform_set = false
}

pub fn (tb mut TextBatch) end() {
	tb.flush()
	tb.last_appended_char_cnt = 0
	tb.char_cnt = 0
	tb.img.id = 0
}

fn (tb mut TextBatch) draw_q_m(quad &math.Quad, matrix &math.Mat32, color &math.Color) {
	base_vert := tb.char_cnt * 4
	tb.char_cnt++
	matrix.transform_vec2_arr(&tb.verts[base_vert], &quad.positions[0], 4)

	for i in 0..4 {
		tb.verts[base_vert + i].s = quad.texcoords[i].x
		tb.verts[base_vert + i].t = quad.texcoords[i].y
		tb.verts[base_vert + i].color = *color
	}
}

pub fn (tb mut TextBatch) draw_text(font &fonts.FontStash, str string, config DrawConfig) {
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
		tb.draw_q_m(tb.quad, matrix, math.Color{iter.color})
	}
}

pub fn (tb mut TextBatch) flush() {
	total_quads := (tb.char_cnt - tb.last_appended_char_cnt)
	if total_quads == 0 { return }

	total_verts := total_quads * 4
	tb.bindings.vertex_buffer_offsets[0] = sg_append_buffer(tb.bindings.vertex_buffers[0], &tb.verts[tb.last_appended_char_cnt * 4], sizeof(math.Vertex) * total_verts)
	tb.last_appended_char_cnt = tb.char_cnt

	sg_apply_bindings(&tb.bindings)
	if !tb.uniform_set {
		sg_apply_uniforms(gfx.ShaderStage.vs, 0, &tb.trans_mat, sizeof(math.Mat44))
		tb.uniform_set = true
	}
	sg_draw(0, total_quads * 6, 1)
}

pub fn (tb &TextBatch) free() {
	tb.bindings.vertex_buffers[0].free()
	// tb.bindings.index_buffer.free() // V bug cant find sg_buffer
	sg_destroy_buffer(tb.bindings.index_buffer)

	unsafe {
		tb.verts.free()
		free(tb)
	}
}