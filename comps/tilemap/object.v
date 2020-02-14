module tilemap

pub enum ObjectShape {
	box,
	circle,
	ellipse,
	point,
	polygon
}

pub struct Object {
	id int
	name string
	shape ObjectShape
	x f32
	y f32
	w f32
	h f32
}
