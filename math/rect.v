module math

pub struct Rect {
pub mut:
	x int
	y int
	w int
	h int
}

pub fn (r &Rect) str() string { return '$r.x, $r.y, $r.w, $r.h' }

[inline]
pub fn (r &Rect) right() int { return r.x + r.w }

[inline]
pub fn (r &Rect) bottom() int { return r.y + r.h }

[inline]
pub fn (r1 &Rect) overlaps(r2 &Rect) bool {
	return r2.x < r1.x + r1.right() && r1.x < r2.right() && r2.y < r1.bottom() && r1.y < r2.bottom()
}

[inline]
pub fn (r &Rect) contains(x, y int) bool {
	return r.x <= x && x < r.right() && r.y <= y && y < r.bottom()
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