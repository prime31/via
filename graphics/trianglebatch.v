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

fn (tb &TriangleBatch) ensure_capacity(tris int) bool {
	if tb.tri_cnt + tris > tb.max_tris {
		println('Error: TriangleBatch full. Aborting draw.')
		return false
	}
	return true
}

pub fn (tb mut TriangleBatch) begin() {}

pub fn (tb mut TriangleBatch) end() {
	tb.flush()
	tb.last_appended_tri_cnt = 0
	tb.tri_cnt = 0
	tb.tex.img.id = 0
}

pub fn (tb mut TriangleBatch) draw_triangle(x1, y1, x2, y2, x3, y3 f32) {
	if !tb.ensure_capacity(1) { return }

	base_vert := tb.tri_cnt * 3
	tb.tri_cnt++

	tb.verts[base_vert].x = x1
	tb.verts[base_vert].y = y1
	tb.verts[base_vert + 1].x = x2
	tb.verts[base_vert + 1].y = y2
	tb.verts[base_vert + 2].x = x3
	tb.verts[base_vert + 2].y = y3
}

pub fn (tb mut TriangleBatch) draw_rectangle(x, y, width, height f32) {
	tb.draw_polygon([math.Vec2{x, y}, math.Vec2{x + width, y}, math.Vec2{x + width, y + height}, math.Vec2{x, y + height}]!)
}

pub fn (tb mut TriangleBatch) draw_polygon(verts []math.Vec2) {
	for i in 1..verts.len - 1 {
		tb.draw_triangle(verts[0].x, verts[0].y, verts[i].x, verts[i].y, verts[i + 1].x, verts[i + 1].y)
	}
}

pub fn (tb mut TriangleBatch) draw_circle(x, y, radius f32, segments int) {
	if !tb.ensure_capacity(segments) { return }

	center := math.Vec2{x, y}
	increment := math.pi * 2.0 / segments
	mut theta := 0.0

	mut sin_cos := math.Vec2{math.cos(theta), math.sin(theta)}
	v0 := center + sin_cos.scale(radius)
	theta += increment

	for i in 1..segments - 1 {
		sin_cos = math.Vec2{math.cos(theta), math.sin(theta)}
		v1 := center + sin_cos.scale(radius)

		sin_cos = math.Vec2{math.cos(theta + increment), math.sin(theta + increment)}
		v2 := center + sin_cos.scale(radius)

		tb.draw_triangle(v0.x, v0.y, v1.x, v1.y, v2.x, v2.y)

		theta += increment
	}
}

pub fn (tb mut TriangleBatch) flush() {
	total_tris := (tb.tri_cnt - tb.last_appended_tri_cnt)
	if total_tris == 0 { return }

	total_verts := total_tris * 3
	tb.bindings.vertex_buffer_offsets[0] = sg_append_buffer(tb.bindings.vertex_buffers[0], &tb.verts[tb.last_appended_tri_cnt * 3], sizeof(math.Vertex) * total_verts)
	tb.last_appended_tri_cnt = tb.tri_cnt

	sg_apply_bindings(&tb.bindings)
	sg_draw(0, total_tris * 3, 1)
}

pub fn (tb &TriangleBatch) free() {
	tb.bindings.vertex_buffers[0].free()
	tb.bindings.index_buffer.free()
	tb.tex.free()

	unsafe {
		tb.verts.free()
		free(tb)
	}
}