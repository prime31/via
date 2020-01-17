module math

pub struct Vertex {
pub mut:
	x f32
	y f32
	s f32
	t f32
	color Color = Color{0xffffffff}
}

pub fn (v Vertex) str() string {
	return 'pos: $v.x, $v.y, texcoords: $v.s, $v.t, color: $v.color'
}