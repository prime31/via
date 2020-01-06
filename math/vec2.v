module math

pub struct Vec2 {
pub mut:
    x f32
    y f32
}

pub fn (a Vec2) str() string { return '{$a.x, $a.y}' }

fn (a Vec2) + (b Vec2) Vec2 {
	return Vec2 {
		a.x + b.x,
		a.y + b.y
	}
}

fn (a Vec2) - (b Vec2) Vec2 {
	return Vec2 {
		a.x - b.x,
		a.y - b.y
	}
}

pub fn (a Vec2) eq(b Vec2) bool { return a.x == b.x && a.y == b.y }

pub fn (self Vec2) scale(s f32) Vec2 { return Vec2 {self.x * s, self.y * s} }

pub fn (self Vec2) square_magnitude() f32 { return self.x * self.x + self.y * self.y }

pub fn (self Vec2) magnitude() f32 { return C.sqrtf(self.square_magnitude()) }

pub fn (self Vec2) normalize() Vec2 { return self.scale(1.0 / self.magnitude()) }

pub fn (self Vec2) dot(other Vec2) f32 { return self.x * other.x + self.y * other.y }

pub fn (self Vec2) distance_to(other Vec2) f32 { return (other - self).magnitude() }