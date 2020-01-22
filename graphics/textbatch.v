module graphics
import via.math
import via.utils
import via.libs.sokol.gfx

pub struct TextBatch {
mut:
	bindings sg_bindings
	verts []math.Vertex
	max_chars int
	char_cnt int = 0
	last_appended_char_cnt int = 0
	tex Texture
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

fn (tb &TextBatch) ensure_capacity() bool {
	if tb.char_cnt == tb.max_chars {
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
	tb.tex.img.id = 0
}

pub fn (tb mut TextBatch) draw_q_m(tex Texture, quad &math.Quad, matrix &math.Mat32) {
	if !tb.ensure_capacity() { return }
	if tb.tex.ne(tex) {
		tb.flush()
		tb.bindings.set_frag_image(0, tex.img)
		tb.tex = tex
	}

	base_vert := tb.char_cnt * 4
	tb.char_cnt++
	matrix.transform_vec2_arr(&tb.verts[base_vert], &quad.positions[0], 4)

	for i in 0..4 {
		tb.verts[base_vert + i].s = quad.texcoords[i].x
		tb.verts[base_vert + i].t = quad.texcoords[i].y
	}
}

pub fn (tb mut TextBatch) draw_q(tex Texture, quad &math.Quad, config DrawConfig) {
	tb.draw_q_m(tex, quad, config.get_matrix())
}

pub fn (tb mut TextBatch) draw(tex Texture, config DrawConfig) {
	tb.quad.set_image_dimensions(tex.width, tex.height)
	tb.quad.set_viewport(0, 0, tex.width, tex.height)

	tb.draw_q_m(tex, tb.quad, config.get_matrix())
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