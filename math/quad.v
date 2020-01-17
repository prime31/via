module math

// TODO: when fixed sized arrays are fixed these should be fixed
pub struct Quad {
	img_width int
	img_height int
pub mut:
	positions []Vec2
	texcoords []Vec2
}

pub fn quad_make(x, y, width, height f32, img_width, img_height int) Quad {
	mut q := Quad{
		img_width: img_width
		img_height: img_height
		positions: make(4, 4, sizeof(Vec2))
		texcoords: make(4, 4, sizeof(Vec2))
	}
	q.set_viewport(x, y, width, height)
	return q
}

pub fn (q mut Quad) set_viewport(x, y, width, height f32) {
	q.positions[0] = Vec2{0, 0} // tl
	q.positions[1] = Vec2{width, 0} // tr
	q.positions[2] = Vec2{width, height} // br
	q.positions[3] = Vec2{0, height} // bl

	q.texcoords[0] = Vec2{x / q.img_width, y / q.img_height}
	q.texcoords[1] = Vec2{((x + width) / q.img_width), (y / q.img_height)}
	q.texcoords[2] = Vec2{((x + width) / q.img_width), ((y + height) / q.img_height)}
	q.texcoords[3] = Vec2{(x / q.img_width), ((y + height) / q.img_height)}
}

pub fn (q &Quad) free() {
	unsafe {
		q.positions.free()
		q.texcoords.free()
	}
}