module physics
import via.math

pub struct Manifold {
pub mut:
	collided bool
	depth f32
	contact_pt math.Vec2
	// always points from shape A to shape B (first and second shapes passed into any of the functions)
	normal math.Vec2
}

pub fn (mut m Manifold) invert() &Manifold {
	m.normal = m.normal.scale(-1)
	return m
}