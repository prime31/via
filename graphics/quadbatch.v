module graphics
import via.math
import via.utils
import via.libs.sokol.gfx

pub struct QuadBatch {
mut:
	bindings sg_bindings
	verts []math.Vertex
	max_sprites int
	quad_cnt int = 0
	last_appended_quad_cnt int = 0
	tex Texture
	quad math.Quad
	trans_mat math.Mat32
	uniform_set bool
}

pub fn quadbatch(max_sprites int) &QuadBatch {
	mut qb := &QuadBatch{
		// default colors to white
		verts: utils.new_arr_with_default(max_sprites * 4, max_sprites * 4, math.Vertex{})
		max_sprites: max_sprites
		quad: math.quad(0, 0, 1, 1, 1, 1)
	}

	indices := new_vert_quad_index_buffer(max_sprites)
	qb.bindings = bindings_create(qb.verts, .stream, indices, .immutable)
	unsafe { indices.free() }

	return qb
}

fn (qb &QuadBatch) ensure_capacity() bool {
	if qb.quad_cnt == qb.max_sprites {
		println('Error: quadbatch full. Aborting daw.')
		return false
	}
	return true
}

pub fn (qb mut QuadBatch) begin(trans_mat math.Mat32) {
	qb.trans_mat = trans_mat
	qb.uniform_set = false
}

pub fn (qb mut QuadBatch) end() {
	qb.flush()
	qb.last_appended_quad_cnt = 0
	qb.quad_cnt = 0
	qb.tex.img.id = 0
}

pub fn (qb mut QuadBatch) draw_q_m(tex Texture, quad &math.Quad, matrix &math.Mat32) {
	if !qb.ensure_capacity() { return }
	if qb.tex.ne(tex) {
		qb.flush()
		qb.bindings.set_frag_image(0, tex.img)
		qb.tex = tex
	}

	base_vert := qb.quad_cnt * 4
	qb.quad_cnt++
	matrix.transform_vec2_arr(&qb.verts[base_vert], &quad.positions[0], 4)

	for i in 0..4 {
		qb.verts[base_vert + i].s = quad.texcoords[i].x
		qb.verts[base_vert + i].t = quad.texcoords[i].y
	}
}

pub fn (qb mut QuadBatch) draw_q(tex Texture, quad &math.Quad, config DrawConfig) {
	qb.draw_q_m(tex, quad, config.get_matrix())
}

pub fn (qb mut QuadBatch) draw(tex Texture, config DrawConfig) {
	qb.quad.set_image_dimensions(tex.width, tex.height)
	qb.quad.set_viewport(0, 0, tex.width, tex.height)

	qb.draw_q_m(tex, qb.quad, config.get_matrix())
}

pub fn (qb mut QuadBatch) flush() {
	total_quads := (qb.quad_cnt - qb.last_appended_quad_cnt)
	if total_quads == 0 { return }

	total_verts := total_quads * 4
	qb.bindings.vertex_buffer_offsets[0] = sg_append_buffer(qb.bindings.vertex_buffers[0], &qb.verts[qb.last_appended_quad_cnt * 4], sizeof(math.Vertex) * total_verts)
	qb.last_appended_quad_cnt = qb.quad_cnt

	sg_apply_bindings(&qb.bindings)
	if !qb.uniform_set {
		sg_apply_uniforms(gfx.ShaderStage.vs, 0, &qb.trans_mat, sizeof(math.Mat32))
		qb.uniform_set = true
	}
	sg_draw(0, total_quads * 6, 1)
}

pub fn (qb &QuadBatch) free() {
	qb.bindings.vertex_buffers[0].free()
	// qb.bindings.index_buffer.free() // V bug cant find sg_buffer
	sg_destroy_buffer(qb.bindings.index_buffer)

	unsafe {
		qb.verts.free()
		free(qb)
	}
}