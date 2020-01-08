module math

/* OpenGL compatible 3x2 matrix
 *
 * m[0] m[2] m[4]
 * m[1] m[3] m[5]
 *
 * 0: scaleX	2: sin		4: transX
 * 1: cos		3: scaleY	5: transY
 */
struct Mat32 {
pub:
    data [6]f32
}

pub fn (self Mat32) + (other Mat32) Mat32 {
    mut result := Mat32{}
    result.data[0] = self.data[0] + other.data[0]
    result.data[1] = self.data[1] + other.data[1]

    result.data[2] = self.data[2] + other.data[2]
    result.data[3] = self.data[3] + other.data[3]

    result.data[4] = self.data[4] + other.data[4]
    result.data[5] = self.data[5] + other.data[5]
    return result
}

pub fn mat32_zero() Mat32 {
    mut result := Mat32{}
    C.memset(&result, 0, sizeof(Mat32))
    return result
}

pub fn mat32_identity() Mat32 {
    mut result := mat32_zero()
    result.data[0] = 1.0
    result.data[3] = 1.0
    return result
}

pub fn mat32_rotate(angle f32) Mat32 {
	mut result := mat32_identity()
    c := cosf(angle)
    s := sinf(angle)

	result.data[0] = c
	result.data[1] = s
	result.data[2] = s
	result.data[3] = c

    return result
}

pub fn mat32_scale(sx f32, sy f32) Mat32 {
    mut result := mat32_identity()
    result.data[0] = sx
    result.data[3] = sy
    return result
}

pub fn (self Mat32) det() f32 {
    return self.data[0] * self.data[3] - self.data[1] * self.data[2]
}

pub fn (self Mat32) get_translation() Vec2 {
	return Vec2{self.data[4], self.data[5]}
}

pub fn (self Mat32) get_radians() f32 {
	return atan2(self.data[2], self.data[1])
}

pub fn (self Mat32) get_degrees() f32 {
	return degrees(self.get_radians())
}

pub fn (self Mat32) get_scale() Vec2 {
	return Vec2{self.data[0], self.data[3]}
}