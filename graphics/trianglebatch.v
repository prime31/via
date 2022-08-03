module graphics
import via.math
import via.utils
import via.libs.sokol.gfx

pub const ( trib_import = gfx.used_import )

pub struct TriangleBatch {
mut:
	bindings C.sg_bindings
	verts []math.Vertex
	max_tris int
	tri_cnt int = 0
	last_appended_tri_cnt int = 0
	tex Texture
}

pub fn trianglebatch(max_tris int) &TriangleBatch {
	// 2x2 white pixel texture
	pixels := [u32(0xFFFFFFFF), 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF]/*!*/

	//arr := utils.new_arr_with_default<math.Vertex>(max_tris * 3, max_tris * 3, math.Vertex{})
	arr := []math.Vertex{len: max_tris * 3, cap: max_tris * 3, init: math.Vertex{}}
	mut tb := &TriangleBatch{
		// default colors to white
		verts: arr
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

pub fn (mut tb TriangleBatch) end() {
	tb.flush()
	tb.last_appended_tri_cnt = 0
	tb.tri_cnt = 0
	tb.tex.img.id = 0
}

pub fn (mut tb TriangleBatch) draw_triangle(x1, y1, x2, y2, x3, y3 f32, config DrawConfig) {
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
	unsafe {
		addr := &tb.verts[base_vert]
		matrix.transform_vertex_arr(addr, 3)
	}

}

pub fn (mut tb TriangleBatch) draw_point(x, y, size f32, color math.Color) {
	tb.draw_rectangle(size, size, {x:x y:y color:color})
}

pub fn (mut tb TriangleBatch) draw_rectangle(width, height f32, config DrawConfig) {
	// TODO: should this be from center or top-left?
	half_w := width * 0.5
	half_h := height * 0.5
	tb.draw_polygon([math.Vec2{-half_w, -half_h}, math.Vec2{half_w, -half_h}, math.Vec2{half_w, half_h}, math.Vec2{-half_w, half_h}]/*!*/, config)
}

pub fn (mut tb TriangleBatch) draw_hollow_rect(x, y, width, height, thickness f32, color math.Color) {
	half_thick := thickness * 0.5

	tb.draw_line(x - half_thick, y, x + width + half_thick, y, thickness, color)
	tb.draw_line(x + width, y, x + width, y + height, thickness, color)
	tb.draw_line(x - half_thick, y + height, x + width + half_thick, y + height, thickness, color)
	tb.draw_line(x, y + height, x, y, thickness, color)
}

pub fn (mut tb TriangleBatch) draw_polygon(verts []math.Vec2, config DrawConfig) {
	assert verts.len > 1
	for i in 1..verts.len - 1 {
		tb.draw_triangle(verts[0].x, verts[0].y, verts[i].x, verts[i].y, verts[i + 1].x, verts[i + 1].y, config)
	}
}

pub fn (mut tb TriangleBatch) draw_hollow_polygon(x, y f32, verts []math.Vec2, color math.Color) {
	assert verts.len > 1

	for i in 0..verts.len - 1 {
		tb.draw_line(x + verts[i].x, y + verts[i].y, x + verts[i + 1].x, y + verts[i + 1].y, 1, color)
	}
	tb.draw_line(x + verts[verts.len - 1].x, y + verts[verts.len - 1].y, x + verts[0].x, y + verts[0].y, 1, color)
}

pub fn (mut tb TriangleBatch) draw_circle(radius f32, segments int, config DrawConfig) {
	if !tb.ensure_capacity(segments) { return }

	center := math.Vec2{}
	increment := math.pi * 2.0 / segments
	mut theta := f32(0.0)

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

pub fn (mut tb TriangleBatch) draw_hollow_circle(radius f32, segments int, config DrawConfig) {
	center := math.Vec2{config.x, config.y}
	increment := math.pi * 2.0 / segments
	mut theta := f32(0.0)

	mut sin_cos := math.Vec2{math.cos(theta), math.sin(theta)}
	theta += increment

	for _ in 1..segments + 1 {
		sin_cos = math.Vec2{math.cos(theta), math.sin(theta)}
		v1 := center + sin_cos.scale(radius)

		sin_cos = math.Vec2{math.cos(theta + increment), math.sin(theta + increment)}
		v2 := center + sin_cos.scale(radius)

		tb.draw_line(v1.x, v1.y, v2.x, v2.y, 1, config.color)

		theta += increment
	}
}

pub fn (mut tb TriangleBatch) draw_line(x1, y1, x2, y2, thickness f32, color math.Color) {
	v1 := x1 - x2
	v2 := y1 - y2
	dist := math.sqrt(v1 * v1 + v2 * v2)
	angle := math.angle_between_points(x1, y1, x2, y2)
	half_thick := thickness * 0.51

	verts := [math.Vec2{0, -half_thick}, math.Vec2{dist, -half_thick}, math.Vec2{dist, half_thick}, math.Vec2{0, half_thick}] //!
	tb.draw_polygon(verts, {x:x1 y:y1 rot:math.degrees(angle) color:color})
}

pub fn (tbb &TriangleBatch) flush() {
	mut tb := tbb
	total_tris := (tb.tri_cnt - tb.last_appended_tri_cnt)
	if total_tris == 0 { return }

	total_verts := total_tris * 3
	unsafe {
		addr := &tb.verts[tb.last_appended_tri_cnt * 3]
		tb.bindings.vertex_buffer_offsets[0] = C.sg_append_buffer(tb.bindings.vertex_buffers[0], addr, sizeof(math.Vertex) * u32(total_verts))
	}

	tb.last_appended_tri_cnt = tb.tri_cnt

	C.sg_apply_bindings(&tb.bindings)
	C.sg_draw(0, total_tris * 3, 1)
}

pub fn (tb &TriangleBatch) free() {
	tb.bindings.vertex_buffers[0].free()
	tb.bindings.index_buffer.free()
	tb.tex.free()

	unsafe {
		tb.verts.free()
		C.free(tb)
	}
}
