module graphics
import via.math
import via.utils
import via.libs.sokol.gfx

pub struct AtlasBatch {
mut:
	bindings sg_bindings
	v_buffer_safe_to_update bool = true
	v_buffer_dirty bool
	verts []math.Vertex
	sprite_cnt int
	max_sprites int
	tex Texture
}

pub fn atlasbatch_new(tex Texture, max_sprites int) &AtlasBatch {
	mut sb := &AtlasBatch{
		// we use repeat here so that we can set default colors to white
		verts: utils.new_array_with_default(max_sprites * 4, max_sprites * 4, math.Vertex{})
		max_sprites: max_sprites
	}

	indices := new_vert_quad_index_buffer(max_sprites)
	sb.bindings = bindings_create(sb.verts, .dynamic, indices, .immutable)
	sb.set_texture(tex)
	sb.update_verts()
	unsafe { indices.free() }

	return sb
}

// update methods
pub fn (sb mut AtlasBatch) update_verts() {
	if sb.v_buffer_safe_to_update {
		sg_update_buffer(sb.bindings.vertex_buffers[0], sb.verts.data, sizeof(math.Vertex) * sb.verts.len)
		sb.v_buffer_safe_to_update = false
		sb.v_buffer_dirty = false
	}
}

pub fn (sb mut AtlasBatch) set_texture(tex Texture) {
	sb.bindings.set_frag_image(0, tex.id)
	sb.tex = tex
}

pub fn (sb mut AtlasBatch) clear() {
	sb.sprite_cnt = 0
}

fn (sb &AtlasBatch) check_can_add() bool {
	if sb.sprite_cnt == sb.max_sprites {
		println('Error: sprite batch full. Aborting Add.')
		return false
	}
	return true
}

pub fn (sb mut AtlasBatch) set(index int, x, y f32) {
	mut base_vert := index * 4
	// tl
	sb.verts[base_vert].x = x
	sb.verts[base_vert].y = y
	sb.verts[base_vert].s = 0
	sb.verts[base_vert].t = 0
	// tr
	base_vert++
	sb.verts[base_vert].x = x + sb.tex.width
	sb.verts[base_vert].y = y
	sb.verts[base_vert].s = 1
	sb.verts[base_vert].t = 0
	// br
	base_vert++
	sb.verts[base_vert].x = x + sb.tex.width
	sb.verts[base_vert].y = y + sb.tex.height
	sb.verts[base_vert].s = 1
	sb.verts[base_vert].t = 1
	// bl
	base_vert++
	sb.verts[base_vert].x = x
	sb.verts[base_vert].y = y + sb.tex.height
	sb.verts[base_vert].s = 0
	sb.verts[base_vert].t = 1

	sb.v_buffer_dirty = true
}

pub fn (sb mut AtlasBatch) set_q(index int, quad &math.Quad, matrix math.Mat32) {
	base_vert := index * 4

	matrix.transform_vec2_arr(&sb.verts[base_vert], &quad.positions[0], 4)

	for i in 0..4 {
		sb.verts[base_vert + i].s = quad.texcoords[i].x
		sb.verts[base_vert + i].t = quad.texcoords[i].y
	}

	sb.v_buffer_dirty = true
}

pub fn (sb mut AtlasBatch) add(x, y f32) int {
	if !sb.check_can_add() {
		return -1
	}

	sb.set(sb.sprite_cnt, x, y)

	sb.v_buffer_dirty = true
	sb.sprite_cnt++
	return sb.sprite_cnt - 1
}

pub fn (sb mut AtlasBatch) add_q(quad &math.Quad, x, y f32) int {
	return sb.add_q_trso(quad, x, y, 0, 1, 1, 0, 0)
}

pub fn (sb mut AtlasBatch) add_q_trs(quad &math.Quad, x, y, rot, scale_x, scale_y f32) int {
	return sb.add_q_trso(quad, x, y, rot, scale_x, scale_y, 0, 0)
}

pub fn (sb mut AtlasBatch) add_q_trso(quad &math.Quad, x, y, rot, scale_x, scale_y, origin_x, origin_y f32) int {
	if !sb.check_can_add() {
		return -1
	}

	mat := math.mat32_transform(x, y, math.radians(rot), scale_x, scale_y, origin_x, origin_y)
	sb.set_q(sb.sprite_cnt, quad, mat)

	sb.v_buffer_dirty = true
	sb.sprite_cnt++
	return sb.sprite_cnt - 1
}

pub fn (sb mut AtlasBatch) draw(trans_mat &math.Mat44) {
	if sb.v_buffer_dirty {
		sb.update_verts()
	}

	sg_apply_bindings(&sb.bindings)
	sg_apply_uniforms(gfx.ShaderStage.vs, 0, trans_mat, sizeof(math.Mat44))
	sg_draw(0, sb.sprite_cnt * 6, 1)
	sb.v_buffer_safe_to_update = true
}

pub fn (sb &AtlasBatch) free() {
	sb.bindings.vertex_buffers[0].free()
	// sb.bindings.index_buffer.free() // V bug cant find sg_buffer
	sg_destroy_buffer(sb.bindings.index_buffer)

	unsafe {
		sb.verts.free()
		free(sb)
	}
}