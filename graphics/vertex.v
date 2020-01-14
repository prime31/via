module graphics
import via.math

pub struct Vertex {
pub mut:
	pos math.Vec2
	texcoords math.Vec2
	color math.Color
}
pub fn (v Vertex) str() string {
	return 'pos: $v.pos, texcoords: $v.texcoords, color: $v.color'
}