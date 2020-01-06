module time

#define SOKOL_IMPL
#include "sokol_time.h"

[inline]
pub fn setup() {
	C.stm_setup()
}

[inline]
pub fn now() u64 {
	return C.stm_now()
}

[inline]
pub fn diff(new_ticks u64, old_ticks u64) u64 {
	return C.stm_diff(new_ticks, old_ticks)
}

[inline]
pub fn since(start_ticks u64) u64 {
	return C.stm_since(start_ticks)
}

[inline]
pub fn laptime(last_time &u64) u64 {
	return C.stm_laptime(last_time)
}

[inline]
pub fn sec(ticks u64) f64 {
	return C.stm_sec(ticks)
}

[inline]
pub fn ms(ticks u64) f64 {
	return C.stm_ms(ticks)
}

[inline]
pub fn us(ticks u64) f64 {
	return C.stm_us(ticks)
}

[inline]
pub fn ns(ticks u64) f64 {
	return C.stm_ns(ticks)
}

