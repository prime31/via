module graphics
import via.math

pub struct DrawConfig {
	x f32 = 0.0
	y f32 = 0.0
	rot f32 = 0.0
	sx f32 = 1.0
	sy f32 = 1.0
	ox f32 = 0.0
	oy f32 = 0.0
}

pub fn (c &DrawConfig) get_matrix() math.Mat32 {
	return math.mat32_transform(c.x, c.y, math.radians(c.rot), c.sx, c.sy, c.ox, c.oy)
}