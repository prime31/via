module graphics
import via.math
import via.fonts
import via.libs.fontstash

pub struct DrawConfig {
pub mut:
	x f32 = 0.0
	y f32 = 0.0
	rot f32 = 0.0
	sx f32 = 1.0
	sy f32 = 1.0
	ox f32 = 0.0
	oy f32 = 0.0
	color math.Color = math.Color{}
}

pub fn (c &DrawConfig) get_matrix() math.Mat32 {
	return math.mat32_transform(c.x, c.y, math.radians(c.rot), c.sx, c.sy, c.ox, c.oy)
}

pub fn (c &DrawConfig) get_matrix_no_translation() math.Mat32 {
	return math.mat32_transform(0, 0, math.radians(c.rot), c.sx, c.sy, c.ox, c.oy)
}


pub struct TextDrawConfig {
pub mut:
	x f32 = 0.0
	y f32 = 0.0
	rot f32 = 0.0
	sx f32 = 1.0
	sy f32 = 1.0
	ox f32 = 0.0
	oy f32 = 0.0
	fontbook &fonts.FontBook = &fonts.FontBook(0)
	align fontstash.FonsAlign = fontstash.FonsAlign.default
	color math.Color = math.Color{}
}

pub fn (c &TextDrawConfig) get_matrix() math.Mat32 {
	return math.mat32_transform(c.x, c.y, math.radians(c.rot), c.sx, c.sy, c.ox, c.oy)
}