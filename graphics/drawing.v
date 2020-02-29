module graphics
import via.math

//#region QuadBatch

[inline]
pub fn bind_texture(index int, tex Texture) {
	mut gg := g
	gg.quad_batch.bind_texture(index, tex)
}

[inline]
pub fn draw_q_m(tex C.sg_image, quad &math.Quad, matrix &math.Mat32, color &math.Color) {
	mut gg := g
	gg.tri_batch.flush()
	gg.quad_batch.draw_q_m(tex, quad, matrix, color)
}

[inline]
pub fn draw_q(tex Texture, quad &math.Quad, config DrawConfig) {
	mut gg := g
	gg.tri_batch.flush()
	gg.quad_batch.draw_q(tex, quad, config)
}

[inline]
pub fn draw_vp(tex Texture, viewport math.Rect, config DrawConfig) {
	mut gg := g
	gg.tri_batch.flush()
	gg.quad_batch.draw_vp(tex, viewport, config)
}

[inline]
pub fn draw(tex Texture, config DrawConfig) {
	mut gg := g
	gg.tri_batch.flush()
	gg.quad_batch.draw(tex, config)
}

[inline]
pub fn draw_text(str string, config TextDrawConfig) {
	mut gg := g
	gg.tri_batch.flush()
	gg.quad_batch.draw_text(str, config)
}

//#endregion

//#region TriangleBatch

[inline]
pub fn draw_triangle(x1, y1, x2, y2, x3, y3 f32, config DrawConfig) {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.draw_triangle(x1, y1, x2, y2, x3, y3, config)
}

[inline]
pub fn draw_point(x, y, size f32, color math.Color) {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.draw_point(x, y, size, color)
}

[inline]
pub fn draw_rectangle(width, height f32, config DrawConfig) {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.draw_rectangle(width, height, config)
}

[inline]
pub fn draw_hollow_rect(x, y, width, height, thickness f32, color math.Color) {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.draw_hollow_rect(x, y, width, height, thickness, color)
}

[inline]
pub fn draw_polygon(verts []math.Vec2, config DrawConfig) {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.draw_polygon(verts, config)
}

[inline]
pub fn draw_hollow_polygon(x, y f32, verts []math.Vec2, color math.Color) {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.draw_hollow_polygon(x, y, verts, color)
}

[inline]
pub fn draw_circle(radius f32, segments int, config DrawConfig) {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.draw_circle(radius, segments, config)
}

[inline]
pub fn draw_hollow_circle(radius f32, segments int, config DrawConfig) {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.draw_hollow_circle(radius, segments, config)
}

[inline]
pub fn draw_line(x1, y1, x2, y2, thickness f32, color math.Color) {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.draw_line(x1, y1, x2, y2, thickness, color)
}

//#endregion