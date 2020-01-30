module math

pub struct Rect {
pub mut:
	x int
	y int
	w int
	h int
}

pub fn (r &Rect) str() string { return '$r.x, $r.y, $r.w, $r.h' }

pub fn (r &Rect) right() int { return r.x + r.w }

pub fn (r &Rect) bottom() int { return r.y + r.h }

pub fn (r1 &Rect) overlaps(r2 &Rect) bool {
	return r2.x < r1.x + r1.right() && r1.x < r2.right() && r2.y < r1.bottom() && r1.y < r2.bottom()
}

pub fn (r &Rect) contains(x, y int) bool {
	return r.x <= x && x < r.right() && y <= y && y < r.bottom()
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