module math

pub struct Vec3 {
pub mut:
    x f32
    y f32
	z f32
}

pub fn (a Vec3) str() string { return '{$a.x, $a.y, $a.z}' }

fn (a Vec3) + (b Vec3) Vec3 {
	return Vec3 {
		a.x + b.x,
		a.y + b.y,
		a.z + b.z
	}
}

fn (a Vec3) - (b Vec3) Vec3 {
	return Vec3 {
		a.x - b.x,
		a.y - b.y,
		a.z - b.z
	}
}

pub fn (a Vec3) eq(b Vec3) bool { return a.x == b.x && a.y == b.y && a.z == b.z }

pub fn vec3_up() Vec3 { return Vec3{0, 1, 0}}

pub fn (self Vec3) scale(s f32) Vec3 { return Vec3 {self.x * s, self.y * s, self.z * s} }

pub fn (self Vec3) square_magnitude() f32 { return self.x * self.x + self.y * self.y + self.z * self.z }

pub fn (self Vec3) magnitude() f32 { return C.sqrtf(self.square_magnitude()) }

pub fn (self Vec3) normalize() Vec3 { return self.scale(1.0 / self.magnitude()) }

pub fn (self Vec3) dot(other Vec3) f32 { return self.x * other.x + self.y * other.y + self.z * other.z }

pub fn (self Vec3) cross(other Vec3) Vec3 {
    return Vec3 {self.y * other.z - self.z * other.y, self.z * other.x - self.x * other.z, self.x * other.y - self.y * other.x}
}

pub fn (self Vec3) distance_to(other Vec3) f32 { return (other - self).magnitude() }