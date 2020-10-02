module math

pub struct RigidTransform {
pub mut:
	pos Vec2
	cost f32 = 1.0
	sint f32
}

pub fn rigidtransform(pos Vec2) RigidTransform {
	return RigidTransform {
		pos: pos
	}
}

pub fn (mut t RigidTransform) rotate(radians f32) {
	sin, cos := sincos(radians)

	// perform an optimized version of matrix multiplication
	cost := cos * t.cost - sin * t.sint
	sint := sin * t.cost + cos * t.sint
	x := cos * t.pos.x - sin * t.pos.y
	y := sin * t.pos.x + cos * t.pos.y

	t.cost = cost
	t.sint = sint
	t.pos.x = x
	t.pos.y = y
}

pub fn (t &RigidTransform) inverse_transform_rot(mut vec Vec2) {
		x := vec.x
		y := vec.y

		// since the transpose of a rotation matrix is the inverse
		vec.x = t.cost * x + t.sint * y
		vec.y = -t.sint * x + t.cost * y
}

pub fn (t &RigidTransform) get_transformed(vec Vec2) Vec2 {
	mut vec2 := vec
	t.transformed(mut vec2)
	return vec2
}

pub fn (t &RigidTransform) transformed(mut vec Vec2) {
	x := vec.x
	y := vec.y

	vec.x = t.cost * x - t.sint * y + t.pos.x
	vec.y = t.sint * x + t.cost * y + t.pos.y
}