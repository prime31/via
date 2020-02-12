module graphics
import via.math
import via.utils
import via.libs.sokol.gfx

pub const ( trib_import = gfx.used_import )

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
	// 2x2 white pixel texture
	pixels := [u32(0xFFFFFFFF), 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF]!

	mut tb := &TriangleBatch{
		// default colors to white
		verts: utils.new_arr_with_default(max_tris * 3, max_tris * 3, math.Vertex{})
		max_tris: max_tris
		tex: texture_from_data(2, 2, pixels)
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

pub fn (tb mut TriangleBatch) end() {
	tb.flush()
	tb.last_appended_tri_cnt = 0
	tb.tri_cnt = 0
	tb.tex.img.id = 0
}

pub fn (tb mut TriangleBatch) draw_triangle(x1, y1, x2, y2, x3, y3 f32, config DrawConfig) {
	if !tb.ensure_capacity(1) { return }

	base_vert := tb.tri_cnt * 3
	tb.tri_cnt++

	tb.verts[base_vert].x = x1
	tb.verts[base_vert].y = y1
	tb.verts[base_vert].color = config.color
	tb.verts[base_vert + 1].x = x2
	tb.verts[base_vert + 1].y = y2
	tb.verts[base_vert + 1].color = config.color
	tb.verts[base_vert + 2].x = x3
	tb.verts[base_vert + 2].y = y3
	tb.verts[base_vert + 2].color = config.color

	matrix := config.get_matrix()
	matrix.transform_vertex_arr(&tb.verts[base_vert], 3)
}

pub fn (tb mut TriangleBatch) draw_rectangle(width, height f32, config DrawConfig) {
	half_w := width * 0.5
	half_h := height * 0.5
	tb.draw_polygon([math.Vec2{-half_w, -half_h}, math.Vec2{half_w, -half_h}, math.Vec2{half_w, half_h}, math.Vec2{-half_w, half_h}]!, config)
}

pub fn (tb mut TriangleBatch) draw_polygon(verts []math.Vec2, config DrawConfig) {
	for i in 1..verts.len - 1 {
		tb.draw_triangle(verts[0].x, verts[0].y, verts[i].x, verts[i].y, verts[i + 1].x, verts[i + 1].y, config)
	}
}

pub fn (tb mut TriangleBatch) draw_circle(radius f32, segments int, config DrawConfig) {
	if !tb.ensure_capacity(segments) { return }

	center := math.Vec2{}
	increment := math.pi * 2.0 / segments
	mut theta := 0.0

	mut sin_cos := math.Vec2{math.cos(theta), math.sin(theta)}
	v0 := center + sin_cos.scale(radius)
	theta += increment

	for _ in 1..segments - 1 {
		sin_cos = math.Vec2{math.cos(theta), math.sin(theta)}
		v1 := center + sin_cos.scale(radius)

		sin_cos = math.Vec2{math.cos(theta + increment), math.sin(theta + increment)}
		v2 := center + sin_cos.scale(radius)

		tb.draw_triangle(v0.x, v0.y, v1.x, v1.y, v2.x, v2.y, config)

		theta += increment
	}
}

pub fn (tbb &TriangleBatch) flush() {
	mut tb := tbb
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