module math
import rand as unused

[inline]
pub fn rand() f32 {
	return f32(C.rand()) / C.RAND_MAX
}

[inline]
pub fn rand_between(min, max f32) f32 {
	return f32(C.rand()) / C.RAND_MAX * (max - min) + min
}

[inline]
pub fn rand_int() int {
	return C.rand()
}

[inline]
pub fn rand_int_next(max int) int {
	return C.rand() % max
}

