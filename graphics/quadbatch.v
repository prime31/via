module graphics
import via.math
import via.fonts
import via.utils
import via.libs.sokol.gfx

const ( used = gfx.used_import )

pub struct QuadBatch {
mut:
	bindings sg_bindings
	verts []math.Vertex
	max_sprites int
	quad_cnt int = 0
	last_appended_quad_cnt int = 0
	tex_id u32
	quad math.Quad
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
		println('Error: quadbatch full. Aborting draw.')
		return false
	}
	return true
}

pub fn (qb mut QuadBatch) begin() {
}

pub fn (qb mut QuadBatch) end() {
	qb.flush()
	qb.last_appended_quad_cnt = 0
	qb.quad_cnt = 0
	qb.tex_id = 0
}

pub fn (qb mut QuadBatch) draw_q_m(tex C.sg_image, quad &math.Quad, matrix &math.Mat32, color &math.Color) {
	if !qb.ensure_capacity() { return }
	if qb.tex_id != tex.id {
		qb.flush()
		qb.bindings.set_frag_image(0, tex)
		qb.tex_id = tex.id
	}

	base_vert := qb.quad_cnt * 4
	qb.quad_cnt++
	matrix.transform_vec2_arr(&qb.verts[base_vert], &quad.positions[0], 4)

	for i in 0..4 {
		qb.verts[base_vert + i].s = quad.texcoords[i].x
		qb.verts[base_vert + i].t = quad.texcoords[i].y
		qb.verts[base_vert + i].color = *color
	}
}

pub fn (qb mut QuadBatch) draw_q(tex Texture, quad &math.Quad, config DrawConfig) {
	qb.draw_q_m(tex.img, quad, config.get_matrix(), config.color)
}

pub fn (qb mut QuadBatch) draw(tex Texture, config DrawConfig) {
	qb.quad.set_image_dimensions(tex.w, tex.h)
	qb.quad.set_viewport(0, 0, tex.w, tex.h)

	qb.draw_q_m(tex.img, qb.quad, config.get_matrix(), config.color)
}

pub fn (qb mut QuadBatch) draw_text(font &fonts.FontBook, str string, config DrawConfig) {
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
		qb.quad.positions[0] = math.Vec2{fons_quad.x0, fons_quad.y0}
		qb.quad.positions[1] = math.Vec2{fons_quad.x1, fons_quad.y0}
		qb.quad.positions[2] = math.Vec2{fons_quad.x1, fons_quad.y1}
		qb.quad.positions[3] = math.Vec2{fons_quad.x0, fons_quad.y1}

		qb.quad.texcoords[0] = math.Vec2{fons_quad.s0, fons_quad.t0}
		qb.quad.texcoords[1] = math.Vec2{fons_quad.s1, fons_quad.t0}
		qb.quad.texcoords[2] = math.Vec2{fons_quad.s1, fons_quad.t1}
		qb.quad.texcoords[3] = math.Vec2{fons_quad.s0, fons_quad.t1}
		qb.draw_q_m(font.img, qb.quad, matrix, config.color)
	}
}

pub fn (qb mut QuadBatch) flush() {
	total_quads := (qb.quad_cnt - qb.last_appended_quad_cnt)
	if total_quads == 0 { return }

	total_verts := total_quads * 4
	qb.bindings.vertex_buffer_offsets[0] = sg_append_buffer(qb.bindings.vertex_buffers[0], &qb.verts[qb.last_appended_quad_cnt * 4], sizeof(math.Vertex) * total_verts)
	qb.last_appended_quad_cnt = qb.quad_cnt

	sg_apply_bindings(&qb.bindings)
	sg_draw(0, total_quads * 6, 1)
}

pub fn (qb &QuadBatch) free() {
	qb.bindings.vertex_buffers[0].free()
	qb.bindings.index_buffer.free()

	unsafe {
		qb.verts.free()
		free(qb)
	}
}