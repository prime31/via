module math

pub struct Vertex {
pub mut:
	pos Vec2
	texcoords Vec2
	color Color
}

pub fn (v Vertex) str() string {
	return 'pos: $v.pos, texcoords: $v.texcoords, color: $v.color'
}