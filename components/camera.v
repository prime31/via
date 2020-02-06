module components
import via.math
import via.window

pub struct Camera {
pub mut:
	pos math.Vec2 = math.Vec2{0, 0}
	rot f32 = 0.0
	scale math.Vec2 = math.Vec2{1, 1}
}

pub fn camera() Camera {
	return Camera{}
}

pub fn (c &Camera) trans_mat() math.Mat32 {
	return math.mat32_transform(c.pos.x, c.pos.y, c.rot, c.scale.x, c.scale.y, 0, 0)
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

pub fn (c &Camera) screen_to_world(x, y int) (int, int) {
	// we use an offcenter ortho projection so we first shift the coordinates by half the drawable size
	w, h := window.drawable_size()
	mut tx := x - w / 2
	mut ty := y - h / 2

	trans_x, trans_y := c.inv_transform_xy(tx, ty)
	return int(trans_x), int(trans_y)
}

// x.y should be the scaled mouse coordinates. os_w,os_h are the render target width/height.
// sx,sy are the final render scale values from the OffscreenPass
pub fn (c &Camera) screen_to_offscreen_world(x, y, os_w, os_h int, sx, sy f32) (int, int) {
	// offset the mouse pos by half the render target width due to offcenter ortho projection
	tx := f32(x - os_w / 2)
	ty := f32(y - os_h / 2)

	trans_x, trans_y := c.inv_transform_xy(tx, ty)
	return int(trans_x), int(trans_y)
}