module math

fn C.rand() int

pub fn seed(s int) {
	C.srand(s)
}

[inline]
pub fn rand() f32 {
	return f32(C.rand()) / C.RAND_MAX
}

[inline]
pub fn range(min, max f32) f32 {
	return f32(C.rand()) / C.RAND_MAX * (max - min) + min
}

[inline]
pub fn range_int(min, max int) int {
	return C.rand() % (max - min) + min
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
pub fn int_next(max int) int {
	return C.rand() % max
}

[inline]
pub fn take<T>(a bool, b T, c T) T {
	if a { return b }
	return c
}

// Returns b if c is true, a otherwise
[inline]
pub fn choose(a bool, b, c f32) f32 {
	if a { return b }
	return c
}

[inline]
pub fn choose_arr<T>(a []T) T {
	return a[int_next(a.len)]
}

// randomly returns a or b
[inline]
pub fn choose_t<T>(a, b T) T {
	if rand_01() > 0.5 { return b }
	return a
}

[inline]
pub fn choose3<T>(a, b, c T) T {
	return match int_next(3) {
		0 { a }
		1 { b }
		else { c }
	}
}

[inline]
pub fn choose4<T>(a, b, c, d T) T {
	return match int_next(4) {
		0 { a }
		1 { b }
		2 { c }
		else { d }
	}
}

[inline]
pub fn choice<T>(args...T) T {
	assert(true) // TODO: doesnt work yet, tmp.len errors
	// choice := rand_int_next(tmp.len)
	return args[0]
}
