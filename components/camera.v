module components
import via.math

pub struct Camera {
pub mut:
	pos math.Vec2 = math.Vec2{0, 0}
	rot f32 = 0.0
	scale math.Vec2 = math.Vec2{1, 1}
}

pub fn camera() Camera {
	return Camera{}
}

pub fn (c &Camera) get_trans_mat() math.Mat32 {
	return math.mat32_transform(c.pos.x, c.pos.y, c.rot, c.scale.x, c.scale.y, 0, 0)
}