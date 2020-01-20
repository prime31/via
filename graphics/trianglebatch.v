module graphics
import via.math
import via.utils
import via.libs.sokol.gfx

pub struct TriangleBatch {
mut:
	bindings sg_bindings
	verts []math.Vertex
	max_tris int
	tri_cnt int = 0
	last_appended_tri_cnt int = 0
	tex Texture
	trans_mat math.Mat44
	uniform_set bool
}

pub fn trianglebatch(max_tris int) &TriangleBatch {
	mut tb := &TriangleBatch{
		// default colors to white
		verts: utils.new_arr_with_default(max_tris * 3, max_tris * 3, math.Vertex{})
		max_tris: max_tris
		tex: new_checker_texture()
	}

	indices := new_vert_tri_index_buffer(max_tris)
	tb.bindings = bindings_create(tb.verts, .stream, indices, .immutable)
	tb.bindings.set_frag_image(0, tb.tex.img)
	unsafe { indices.free() }

	return tb
}

fn (tb &TriangleBatch) ensure_capacity() bool {
	if tb.tri_cnt == tb.max_tris {
		println('Error: TriangleBatch full. Aborting daw.')
		return false
	}
	return true
}

pub fn (tb mut TriangleBatch) begin(trans_mat math.Mat44) {
	tb.trans_mat = trans_mat
	tb.uniform_set = false
}

pub fn (tb mut TriangleBatch) end() {
	tb.flush()
	tb.last_appended_tri_cnt = 0
	tb.tri_cnt = 0
	tb.tex.img.id = 0
}

pub fn (tb mut TriangleBatch) set_tri_verts(x1, y1, x2, y2, x3, y3 f32) {
	if !tb.ensure_capacity() { return }

	base_vert := tb.tri_cnt * 3
	tb.tri_cnt++

	tb.verts[base_vert].x = x1
	tb.verts[base_vert].y = y1
	tb.verts[base_vert + 1].x = x2
	tb.verts[base_vert + 1].y = y2
	tb.verts[base_vert + 2].x = x3
	tb.verts[base_vert + 2].y = y3
}

pub fn (tb mut TriangleBatch) flush() {
	total_tris := (tb.tri_cnt - tb.last_appended_tri_cnt)
	if total_tris == 0 { return }

	total_verts := total_tris * 3
	tb.bindings.vertex_buffer_offsets[0] = sg_append_buffer(tb.bindings.vertex_buffers[0], &tb.verts[tb.last_appended_tri_cnt * 3], sizeof(math.Vertex) * total_verts)
	tb.last_appended_tri_cnt = tb.tri_cnt

	sg_apply_bindings(&tb.bindings)
	if !tb.uniform_set {
		sg_apply_uniforms(gfx.ShaderStage.vs, 0, &tb.trans_mat, sizeof(math.Mat44))
		tb.uniform_set = true
	}
	sg_draw(0, total_tris * 3, 1)
}

pub fn (tb &TriangleBatch) free() {
	tb.bindings.vertex_buffers[0].free()
	// tb.bindings.index_buffer.free() // V bug cant find sg_buffer
	sg_destroy_buffer(tb.bindings.index_buffer)
	tb.tex.free()

	unsafe {
		tb.verts.free()
		free(tb)
	}
}