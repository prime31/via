module math

pub struct RectF {
pub mut:
	x f32
	y f32
	w f32
	h f32
}

pub fn (r &RectF) str() string { return '$r.x, $r.y, $r.w, $r.h' }

[inline]
pub fn (r mut RectF) set(x, y, w, h f32) {
	r.x = x
	r.y = y
	r.w = w
	r.h = h
}

[inline]
pub fn (r &RectF) right() f32 { return r.x + r.w }

[inline]
pub fn (r &RectF) bottom() f32 { return r.y + r.h }

[inline]
pub fn (r1 &RectF) overlaps(r2 &RectF) bool {
	return r2.x < r1.x + r1.right() && r1.x < r2.right() && r2.y < r1.bottom() && r1.y < r2.bottom()
}

[inline]
pub fn (r &RectF) contains(x, y f32) bool {
	return r.x <= x && x < r.right() && r.y <= y && y < r.bottom()
}

[inline]
pub fn (r &RectF) contains_pt(x, y f32) bool {
	return x - r.x > delta && y - r.y > delta &&
		r.x + r.w - x > delta && r.y + r.h - y > delta
}

pub fn (r1 &RectF) union_rect(r2 &RectF) RectF {
	mut res := RectF{}
	res.x = min(r1.x, r2.x)
	res.y = min(r1.y, r2.y)
	res.w = max(r1.right(), r2.right()) - res.x
	res.h = max(r1.bottom(), r2.bottom()) - res.y
	return res
}

pub fn (r1 &RectF) union_pt(x, y f32) RectF {
	return r1.union_rect(RectF{x, y, 0, 0})
}

pub fn (r1 &RectF) intersection(r2 &RectF) RectF {
	left := max(r1.x, r2.x)
	right := min(r1.right(), r2.right())
	top := max(r1.y, r2.y)
	bottom := min(r1.bottom(), r2.bottom())

	if left < right && top < bottom {
		return RectF{left, top, right - left, bottom - top}
	} else {
		return RectF{0, 0, 0, 0}
	}
}

pub fn (r1 &RectF) minkowski_diff(r2 &RectF) RectF {
	return RectF{
		x: r2.x - r1.x - r1.w
		y: r2.y - r1.y - r1.h
		w: r1.w + r2.w
		h: r1.h + r2.h
	}
}

fn nearestf(x, a, b f32) f32 {
	if abs(a - x) < abs(b - x) {
		return a
	}
	return b
}

pub fn (r &RectF) get_nearest_corner(x, y f32) (f32, f32) {
	return nearestf(x, r.x, r.x + r.w), nearestf(y, r.y, r.y + r.h)
}