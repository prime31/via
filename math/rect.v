module math

const (
	delta = 1e-10
)

pub struct Rect {
pub mut:
	x int
	y int
	w int
	h int
}

pub fn (r Rect) str() string { return '$r.x, $r.y, $r.w, $r.h' }

[inline]
pub fn (r mut Rect) set(x, y, w, h int) {
	r.x = x
	r.y = y
	r.w = w
	r.h = h
}

[inline]
pub fn (r &Rect) right() int { return r.x + r.w }

[inline]
pub fn (r &Rect) bottom() int { return r.y + r.h }

[inline]
pub fn (r &Rect) center() Vec2 { return Vec2{r.x + r.w / 2, r.y + r.h / 2} }

[inline]
pub fn (r &Rect) centerx() f32 { return r.x + r.w / 2 }

[inline]
pub fn (r &Rect) centery() f32 { return r.y + r.h / 2 }

[inline]
pub fn (r1 &Rect) overlaps(r2 &Rect) bool {
	return r2.x < r1.x + r1.right() && r1.x < r2.right() && r2.y < r1.bottom() && r1.y < r2.bottom()
}

[inline]
pub fn (r &Rect) contains(x, y int) bool {
	return r.x <= x && x < r.right() && r.y <= y && y < r.bottom()
}

[inline]
pub fn (r &Rect) contains_pt(x, y int) bool {
	return f32(x - r.x) > delta && f32(y - r.y) > delta &&
		f32(r.x + r.w - x) > delta && f32(r.y + r.h - y) > delta
}

pub fn (r &Rect) expand(dx, dy int) Rect {
	return Rect{
		x: if dx > 0 { r.x } else { r.x + dx }
		y: if dy > 0 { r.y } else { r.y + dy }
		w: r.w + abs(dx)
		h: r.h + abs(dy)
	}
}

pub fn (r &Rect) half_rect(edge Edge) Rect {
	return match edge {
		.top { Rect{r.x, r.y, r.w, r.h / 2} }
		.bottom { Rect{r.x, r.y + r.h / 2, r.w, r.h / 2} }
		.left { Rect{r.x, r.y, r.w / 2, r.h} }
		.right { Rect{r.x + r.w / 2, r.y, r.w / 2, r.h} }
		else { Rect{} }
	}
}

pub fn (r mut Rect) expand_edge(edge Edge, amount int) {
	// ensure we have a positive value
	amt := abs(amount)

	match edge {
		.top {
			r.y -= amt
			r.h += amt
		}
		.bottom {
			r.h += amt
		}
		.left {
			r.x -= amt
			r.w += amt
		}
		.right {
			r.w += amt
		}
		else {}
	}
}

pub fn (r mut Rect) contract(horiz, vert int) {
	r.x += horiz
	r.y += vert
	r.w -= horiz * 2
	r.h -= vert * 2
}

pub fn (r1 &Rect) union_rect(r2 &Rect) Rect {
	mut res := Rect{}
	res.x = int(min(r1.x, r2.x))
	res.y = int(min(r1.y, r2.y))
	res.w = int(max(r1.right(), r2.right())) - res.x
	res.h = int(max(r1.bottom(), r2.bottom())) - res.y
	return res
}

pub fn (r1 &Rect) union_pt(x, y int) Rect {
	return r1.union_rect(Rect{x, y, 0, 0})
}

pub fn (r1 &Rect) intersection(r2 &Rect) Rect {
	left := imax(r1.x, r2.x)
	right := imin(r1.right(), r2.right())
	top := imax(r1.y, r2.y)
	bottom := imin(r1.bottom(), r2.bottom())

	if left < right && top < bottom {
		return Rect{left, top, right - left, bottom - top}
	} else {
		return Rect{0, 0, 0, 0}
	}
}

pub fn minkowski_diff(r1, r2 &Rect) Rect {
	return Rect{
		x: r2.x - r1.x - r1.w
		y: r2.y - r1.y - r1.h
		w: r1.w + r2.w
		h: r1.h + r2.h
	}
}

fn nearest(x, a, b int) int {
	if abs(a - x) < abs(b - x) {
		return a
	}
	return b
}

pub fn (r &Rect) get_nearest_corner(x, y int) (int, int) {
	return nearest(x, r.x, r.x + r.w), nearest(y, r.y, r.y + r.h)
}