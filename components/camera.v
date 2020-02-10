module components
import via.math
import via.input
import via.graphics

pub struct Camera {
mut:
	res_scaler &graphics.ResolutionScaler
pub mut:
	pos math.Vec2 = math.Vec2{0, 0}
	rot f32 = 0.0
	scale math.Vec2 = math.Vec2{1, 1}
}

pub fn camera() Camera {
	return Camera{
		res_scaler: graphics.get_resolution_scaler()
	}
}

pub fn (c &Camera) trans_mat() math.Mat32 {
	// TODO: why do we get offset rotation when using ox, oy? instead, we just add the offset to the x/y here
	return math.mat32_transform(c.pos.x + c.res_scaler.w / 2, c.pos.y + c.res_scaler.h / 2, c.rot, c.scale.x, c.scale.y, 0, 0)
	// return math.mat32_transform(c.pos.x, c.pos.y, c.rot, c.scale.x, c.scale.y, -c.res_scaler.w / 2, -c.res_scaler.h / 2)
}

// set the camera scale. A value of 3 would be zoom in 3x and a value of 0.5 would be zoomed out 2x
pub fn (c mut Camera) zoom(zoom f32) {
	c.scale.x = zoom
	c.scale.y = zoom
}

// directly transforms x,y with the cameras inverse transform matrix
fn (c &Camera) inv_transform_xy(x, y f32) (f32, f32) {
	trans_mat := c.trans_mat()
	inv_mat := trans_mat.inverse()
	return inv_mat.transform_xy(x, y)
}

// x,y should be the scaled mouse coordinates
pub fn (c &Camera) screen_to_world(x, y int) (int, int) {
	trans_x, trans_y := c.inv_transform_xy(x, y)
	return int(trans_x), int(trans_y)
}

pub fn (c &Camera) mouse_to_world() (int, int) {
	x, y := input.mouse_pos_scaled()
	trans_x, trans_y := c.inv_transform_xy(x, y)
	return int(trans_x), int(trans_y)
}