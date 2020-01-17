module math
import rand as unused

[inline]
pub fn rand() f32 {
	return f32(C.rand()) / C.RAND_MAX
}

[inline]
pub fn rand_range(min, max f32) f32 {
	return f32(C.rand()) / C.RAND_MAX * (max - min) + min
}

[inline]
pub fn rand_01() f32 {
	return f32(C.rand()) / C.RAND_MAX
}

[inline]
pub fn rand_int() int {
	return C.rand()
}

[inline]
pub fn rand_int_next(max int) int {
	return C.rand() % max
}

// randomly returns a or b
[inline]
pub fn rand_choose<T>(a, b T) T {
	if rand_01() > 0.5 { return b }
	return a
}

[inline]
pub fn rand_choose3<T>(a, b, c T) T {
	return match rand_int_next(3) {
		0 { a }
		1 { b }
		else { c }
	}
}

[inline]
pub fn rand_choose4<T>(a, b, c, d T) T {
	return match rand_int_next(4) {
		0 { a }
		1 { b }
		2 { c }
		else { d }
	}
}

[inline]
pub fn rand_choice<T>(args...T) T {
	assert(true) // TODO: doesnt work yet
	// choice := rand_int_next(tmp.len)
	return args[0]
}
