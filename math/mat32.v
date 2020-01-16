module math

/* OpenGL compatible 3x2 matrix
 *
 * m[0] m[2] m[4]
 * m[1] m[3] m[5]
 *
 * 0: scaleX	2: sin		4: transX
 * 1: cos		3: scaleY	5: transY
 */
pub struct Mat32 {
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
	mut result := mat32_zero()
    c := cosf(angle)
    s := sinf(angle)

	result.data[0] = c
	result.data[1] = s
	result.data[2] = -s
	result.data[3] = c

    return result
}

pub fn mat32_scale(sx f32, sy f32) Mat32 {
    mut result := mat32_zero()
    result.data[0] = sx
    result.data[3] = sy
    return result
}

pub fn mat32_skew(x_rad f32, y_rad f32) Mat32 {
    x_tan := tan(x_rad)
    y_tan := tan(y_rad)

    mut result := mat32_zero()
    result.data[0] = 1
    result.data[1] = x_tan
    result.data[2] = y_tan
    result.data[3] = 1
    return result
}

pub fn mat32_ortho(left, right, bottom, top f32) Mat32 {
    mut result := mat32_identity()
    result.data[0] = 2.0 / (right - left)
    result.data[3] = 2.0 / (top - bottom)
    result.data[4] = (left + right) / (left - right)
    result.data[5] = (bottom + top) / (bottom - top)
    return result
}

pub fn mat32_transform(x, y, angle, sx, sy, ox, oy f32) Mat32 {
	mut result := mat32_zero()
    result.set_transform(x, y, angle, sx, sy, ox, oy)
    return result
}

pub fn (m mut Mat32) set_transform(x, y, angle, sx, sy, ox, oy f32) {
    c := cosf(angle)
    s := sinf(angle)

	// matrix multiplication carried out on paper:
	// |1    x| |c -s  | |sx     | |1   -ox|
	// |  1  y| |s  c  | |   sy  | |  1 -oy|
	//   move    rotate    scale     origin
	m.data[0] = c * sx
	m.data[1] = s * sx
	m.data[2] = -s * sy
	m.data[3] = c * sy
	m.data[4] = x - ox * m.data[0] - oy * m.data[2]
	m.data[5] = y - ox * m.data[1] - oy * m.data[3]
}

pub fn (self Mat32) to_mat44_orth() Mat44 {
    mut result := mat44_identity()

    result.data[0] = self.data[0]
    result.data[5] = self.data[3]
    result.data[12] = self.data[4]
    result.data[13] = self.data[5]
    return result
}

pub fn (self Mat32) det() f32 {
    return self.data[0] * self.data[3] - self.data[2] * self.data[1]
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

pub fn (self Mat32) transform_vec2(pos Vec2) Vec2 {
    return Vec2{
        x: pos.x * self.data[0] + pos.y * self.data[2] + self.data[4]
        y: pos.x * self.data[1] + pos.y * self.data[3] + self.data[5]
    }
}

// transforms an array of positions (src) and writes them into the Vertex array (dst)
pub fn (self Mat32) transform_vec2_arr(dst &Vertex, src &Vec2, size int) {
    mut mut_dst := dst

    for i in 0..size {
        x := src[i].x * self.data[0] + src[i].y * self.data[2] + self.data[4]
        y := src[i].x * self.data[1] + src[i].y * self.data[3] + self.data[5]

        mut_dst[i].pos.x = x
        mut_dst[i].pos.y = y
    }
}