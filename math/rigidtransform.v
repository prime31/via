module math

pub struct RigidTransform {
	pos Vec2
	cost f32 = 1.0
	sint f32
}

pub fn rigidtransform(pos Vec2) RigidTransform {
	return RigidTransform {
		pos: pos
	}
}

pub fn (t &RigidTransform) inverse_transform_rot(vec mut Vec2) {
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

pub fn (t &RigidTransform) transformed(vec mut Vec2) {
	x := vec.x
	y := vec.y

	vec.x = t.cost * x - t.sint * y + t.pos.x
	vec.y = t.sint * x + t.cost * y + t.pos.y
}