module utils

pub fn new_array<T>(len int, cap int) []T {
	assert(len <= cap)
	cap_ := if cap == 0 { 1 } else { cap }
	elm_size := sizeof(T)
	arr := array{
		len: len
		cap: cap_
		element_size: elm_size
		data: calloc(cap_ * elm_size)
	}
	return arr
}

pub fn new_array_with_default<T>(len int, cap int, default_val T) []T {
	assert(len <= cap)
	cap_ := if cap == 0 { 1 } else { cap }
	elm_size := sizeof(T)
	arr := array{
		len: len
		cap: cap_
		element_size: elm_size
		data: calloc(cap_ * elm_size)
	}

	mut typed_arr := *T(arr.data)
	for i in 0..len {
		typed_arr[i] = default_val
	}
	return arr
}