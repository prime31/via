module tilemaps

pub const (
	box = 0
	circle = 1
	ellipse = 3
	point = 5
	polygon = 11
)

pub struct Object {
pub mut:
	id int
	name string
	shape int
	x f32
	y f32
	w f32
	h f32
}

pub fn (o &Object) free() {
	unsafe { o.name.free() }
}