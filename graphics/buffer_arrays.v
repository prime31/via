module graphics
import via.utils

fn new_vert_quad_index_buffer(quad_count int) []u16 {
	mut buf := utils.new_array<u16>(quad_count * 3 * 2, quad_count * 3 * 2)
	for i in 0..quad_count {
		buf[i * 3 * 2 + 0] = u16(i) * 4 + 0
		buf[i * 3 * 2 + 1] = u16(i) * 4 + 1
		buf[i * 3 * 2 + 2] = u16(i) * 4 + 2
		buf[i * 3 * 2 + 3] = u16(i) * 4 + 0
		buf[i * 3 * 2 + 4] = u16(i) * 4 + 2
		buf[i * 3 * 2 + 5] = u16(i) * 4 + 3
	}
	return buf
}

fn new_vert_tri_index_buffer(tri_count int) []u16 {
	mut buf := utils.new_array<u16>(tri_count * 3, tri_count * 3)
	for i in 0..tri_count {
		buf[i * 3 + 0] = u16(i) * 3 + 0
		buf[i * 3 + 1] = u16(i) * 3 + 1
		buf[i * 3 + 2] = u16(i) * 3 + 2
	}
	return buf
}