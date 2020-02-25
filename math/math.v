module math

#include <math.h>

pub const (
	max_i32 = 2147483647
	min_i32 = -2147483648
)

//#region C declarations

fn C.acosf(x f32) f32
fn C.asinf(x f32) f32
fn C.atanf(x f32) f32
fn C.atan2f(y f32, x f32) f32
fn C.cbrtf(x f32) f32
fn C.ceilf(x f32) f32
fn C.cosf(x f32) f32
fn C.coshf(x f32) f32
fn C.erff(x f32) f32
fn C.erfcf(x f32) f32
fn C.expf(x f32) f32
fn C.exp2f(x f32) f32
fn C.fabsf(f32) f32
fn C.abs(int) int
fn C.floorf(x f32) f32
fn C.fmodf(x f32, y f32) f32
fn C.fminf(f32, f32) f32
fn C.fmaxf(f32, f32) f32
fn C.hypotf(x f32, y f32) f32
fn C.logf(x f32) f32
fn C.log2f(x f32) f32
fn C.log10f(x f32) f32
fn C.lgammaf(x f32) f32
fn C.powf(x f32, y f32) f32
fn C.roundf(x f32) f32
fn C.sinf(x f32) f32
fn C.sinhf(x f32) f32
fn C.sqrtf(x f32) f32
fn C.tgammaf(x f32) f32
fn C.tanf(x f32) f32
fn C.tanhf(x f32) f32
fn C.truncf(x f32) f32

//#endregion

pub const (
	e = f32(C.M_E)
	pi = f32(C.M_PI)
	pi2 = f32(C.M_PI_2)
	pi4 = f32(C.M_PI_4)
	sqrt2 = f32(C.M_SQRT2)
)

//#region Basic Math ops

[inline]
pub fn radians(x f32) f32 { return x * 0.0174532925 }

[inline]
pub fn degrees(x f32) f32 { return x * 57.295779513 }

[inline]
pub fn min(x, y f32) f32 { return C.fminf(x, y) }

[inline]
pub fn imin(x, y f32) int { return int(C.fminf(x, y)) }

[inline]
pub fn max(x, y f32) f32 { return C.fmaxf(x, y) }

[inline]
pub fn imax(x, y int) int { return int(C.fmaxf(x, y)) }

[inline]
pub fn lerp(x, y, s f32) f32 { return x + s * (y - x) }

[inline]
pub fn unlerp(a, b, x f32) f32 { return (x - a) / (b - a) }

// Returns the result of a non-clamping linear remapping of a value x from [a, b] to [c, d]
[inline]
pub fn remap(a, b, c, d, x f32) f32 { return lerp(c, d, unlerp(a, b, x)) }

[inline]
pub fn clamp(x, a, b f32) f32 { return C.fmaxf(a, C.fminf(b, x)) }

[inline]
pub fn iclamp(x, a, b int) int { return imax(a, imin(b, x)) }

[inline]
pub fn clamp01(val f32) f32 { return clamp(val, 0.0, 1.0) }

// Returns the result of clamping the value x into the interval [0, 1]
[inline]
pub fn saturate(x f32) f32 { return clamp(x, 0.0, 1.0) }

[inline]
pub fn fabs(a f32) f32 { return C.fabsf(a) }

[inline]
pub fn abs(a int) int { return C.abs(a) }

[inline]
pub fn tan(x f32) f32 { return C.tanf(x) }

[inline]
pub fn atan(x f32) f32 { return C.atanf(x) }

[inline]
pub fn atan2(y, x f32) f32 { return C.atan2f(y, x) }

[inline]
pub fn cos(x f32) f32 { return C.cosf(x) }

[inline]
pub fn acos(x f32) f32 { return C.acosf(x) }

[inline]
pub fn sin(x f32) f32 { return C.sinf(x) }

[inline]
pub fn asin(x f32) f32 { return C.asinf(x) }

[inline]
pub fn floor(x f32) f32 { return C.floorf(x) }

[inline]
pub fn ifloor(x f32) int { return int(C.floorf(x)) }

[inline]
pub fn ceil(x f32) f32 { return C.ceilf(x) }

[inline]
pub fn iceil(x f32) int { return int(C.ceilf(x)) }

[inline]
pub fn round(x f32) f32 { return C.roundf(x) }

[inline]
pub fn trunc(x f32) f32 { return C.truncf(x) }

[inline]
pub fn frac(x f32) f32 { return x - floor(x) }

[inline]
pub fn pow(x, y f32) f32 { return C.powf(x, y) }

[inline]
pub fn sqrt(a f32) f32 { return C.sqrtf(a) }

[inline]
pub fn sign(x f32) f32 {
	if x < 0 { return -1 }
	if x > 0 { return 1 }
	return 0
}

//#endregion

// Returns a smooth Hermite interpolation between 0 and 1. when x is in [a, b]
[inline]
pub fn smoothstep(a, b, x f32) f32 {
    t := saturate((x - a) / (b - a))
    return t * t * (3.0 - (2.0 * t))
}

// Splits a float value into an integral part i and a fractional part.
// Both parts take the sign of the input.
[inline]
pub fn modf(x f32) (f32, f32) {
	i := trunc(x)
	return i, x - i
}

// Computes a step function. Returns 1 when x >= y, 0 otherwise
[inline]
pub fn step(y, x f32) f32 { return choose(x >= y, 0.0, 1.0) }

[inline]
pub fn sincos(x f32) (f32, f32) {
	return C.sinf(x), C.cosf(x)
}

[inline]
pub fn ceilpow2_int(i int) int {
	mut x := i
	x--
	x |= x >> 1
	x |= x >> 2
	x |= x >> 4
	x |= x >> 8
	x |= x >> 16
	return x + 1
}

[inline]
pub fn ceilpow2_u32(i u32) u32 {
	mut x := i
	x--
	x |= x >> 1
	x |= x >> 2
	x |= x >> 4
	x |= x >> 8
	x |= x >> 16
	return x + 1
}

[inline]
pub fn ceilpow2_i64(_x i64) i64 {
    if _x == 0 { return 1 }

    mut x := _x
    x--
    x |= x >> 1
    x |= x >> 2
    x |= x >> 4
    x |= x >> 8
    x |= x >> 16
    x |= x >> 32

    return x + 1
}

// loops t so that it is never larger than length and never smaller than 0
[inline]
pub fn repeat(t f32, len f32) f32 { return t - floor(t / len) * len }

// ping-pongs t so that it is never larger than length and never smaller than 0
[inline]
pub fn ping_pong(t, len f32) f32 {
	tt := repeat(t, len * 2)
	return len - fabs(tt - len)
}

// returns true if val is between start and end
[inline]
pub fn between(val, start, end f32) bool {
	return start <= val && val <= end
}

// moves start towards end by shift clamping the result. start can be less than or greater than end.
// example: start is 2, end is 10, shift is 4 results in 6
[inline]
pub fn approach(start, end, shift f32) f32 {
	if start < end { return min(start + shift, end) }
	return max(start - shift, end)
}

// helper for moving a value around in a circle
[inline]
pub fn rotate_around(pos Vec2, speed, time f32) Vec2 {
	x, y := sincos(time * speed)
	return Vec2{pos.x + x, pos.y + y}
}

[inline]
pub fn angle_between_vectors(from, to Vec2) f32 {
	return atan2(to.y - from.y, to.x - from.x)
}

[inline]
pub fn angle_between_points(x1, y1, x2, y2 f32) f32 {
	return atan2(y2 - y1, x2 - x1)
}

//#region Vec2

pub fn absv(a Vec2) Vec2 {
	return Vec2{fabs(a.x), fabs(a.y)}
}

pub fn maxv(a, b Vec2) Vec2 {
	return Vec2{max(a.x, b.x), max(a.y, b.y)}
}

pub fn minv(a, b Vec2) Vec2 {
	return Vec2{min(a.x, b.x), min(a.y, b.y)}
}

pub fn clampv(a, low, high Vec2) Vec2 {
	return maxv(low, minv(a, high))
}

//#endregion