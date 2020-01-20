module math

// TODO: when fixed sized arrays are fixed these should be fixed
pub struct Quad {
pub mut:
	img_width int
	img_height int
	positions []Vec2
	texcoords []Vec2
}

pub fn (q Quad) str() string {
	return 'pos: $q.positions\ntexcoords: $q.texcoords\nimage size: $q.img_width, $q.img_height'
}

pub fn quad(x, y, width, height f32, img_width, img_height int) Quad {
	mut q := Quad{
		img_width: img_width
		img_height: img_height
		positions: make(4, 4, sizeof(Vec2))
		texcoords: make(4, 4, sizeof(Vec2))
	}
	q.set_viewport(x, y, width, height)
	return q
}

pub fn (q mut Quad) set_image_dimensions(img_width, img_height int) {
	q.img_width = img_width
	q.img_height = img_height
}

pub fn (q mut Quad) set_viewport(x, y, width, height f32) {
	q.positions[0] = Vec2{0, 0} // tl
	q.positions[1] = Vec2{width, 0} // tr
	q.positions[2] = Vec2{width, height} // br
	q.positions[3] = Vec2{0, height} // bl

	// squeeze texcoords in by 128th of a pixel to avoid bleed
	w_tol := (1.0 / f32(q.img_width)) / 128.0
	h_tol := (1.0 / f32(q.img_height)) / 128.0

	inv_w := 1.0 / q.img_width
	inv_h := 1.0 / q.img_height

	q.texcoords[0] = Vec2{x * inv_w + w_tol, y * inv_h + h_tol}
	q.texcoords[1] = Vec2{(x + width) * inv_w - w_tol, y * inv_h + h_tol}
	q.texcoords[2] = Vec2{(x + width) * inv_w - w_tol, (y + height) * inv_h - h_tol}
	q.texcoords[3] = Vec2{x * inv_w + w_tol, (y + height) * inv_h - h_tol}
}

pub fn (q &Quad) free() {
	unsafe {
		q.positions.free()
		q.texcoords.free()
	}
}