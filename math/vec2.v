module math

pub struct Vec2 {
pub mut:
    x f32
    y f32
}

pub fn (a Vec2) str() string { return '{$a.x, $a.y}' }

[inline]
fn (a Vec2) + (b Vec2) Vec2 {
	return Vec2 {
		a.x + b.x,
		a.y + b.y
	}
}

[inline]
fn (a Vec2) - (b Vec2) Vec2 {
	return Vec2 {
		a.x - b.x,
		a.y - b.y
	}
}

[inline]
fn (a Vec2) * (b Vec2) Vec2 {
	return Vec2 {
		a.x * b.x,
		a.y * b.y
	}
}

[inline]
pub fn (a Vec2) eq(b Vec2) bool { return a.x == b.x && a.y == b.y }

[inline]
pub fn (self Vec2) scale(s f32) Vec2 { return Vec2{self.x * s, self.y * s} }

[inline]
pub fn (self Vec2) mul(s f32) Vec2 { return Vec2{self.x * s, self.y * s} }

[inline]
pub fn (self Vec2) abs() Vec2 { return Vec2{fabs(self.x), fabs(self.y)} }

[inline]
pub fn (self Vec2) sq_magnitude() f32 { return self.x * self.x + self.y * self.y }

[inline]
pub fn (self Vec2) magnitude() f32 { return C.sqrtf(self.sq_magnitude()) }

[inline]
pub fn (self Vec2) normalize() Vec2 { return self.scale(1.0 / self.magnitude()) }

[inline]
pub fn (self Vec2) dot(other Vec2) f32 { return self.x * other.x + self.y * other.y }

[inline]
pub fn (self Vec2) cross(other Vec2) f32 { return self.x * other.y - self.y * other.x }

[inline]
pub fn (self Vec2) distance_to(other Vec2) f32 { return (other - self).magnitude() }

[inline]
pub fn (self Vec2) sq_distance_to(other Vec2) f32 { return (other - self).sq_magnitude() }