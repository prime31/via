module math

pub struct Vec4 {
pub mut:
    x f32
    y f32
	z f32
	w f32
}

pub fn (a Vec4) str() string { return '{$a.x, $a.y, $a.z, $a.w}' }

fn (a Vec4) + (b Vec4) Vec4 {
	return Vec4 {
		a.x + b.x,
		a.y + b.y,
		a.z + b.z,
		a.w + b.w
	}
}

fn (a Vec4) - (b Vec4) Vec4 {
	return Vec4 {
		a.x - b.x,
		a.y - b.y,
		a.z - b.z,
		a.w - b.w
	}
}

pub fn (a Vec4) eq(b Vec4) bool { return a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w }

pub fn (self Vec4) xyz() Vec3 { return Vec3 {self.x, self.y, self.z} }

pub fn (self Vec4) scale(s f32) Vec4 { return Vec4 {self.x * s, self.y * s, self.z * s, self.w * s} }

pub fn (self Vec4) square_magnitude() f32 { return self.x * self.x + self.y * self.y + self.z * self.z + self.w * self.w }

pub fn (self Vec4) magnitude() f32 { return C.sqrtf(self.square_magnitude()) }

pub fn (self Vec4) normalize() Vec4 { return self.scale(1.0 / self.magnitude()) }

pub fn (self Vec4) dot(other Vec4) f32 { return self.x * other.x + self.y * other.y + self.z * other.z + self.w * other.w }

pub fn (self Vec4) distance_to(other Vec4) f32 { return (other - self).magnitude() }