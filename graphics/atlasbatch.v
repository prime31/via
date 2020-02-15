module graphics
import via.math
import via.utils
import via.libs.sokol.gfx

pub const ( used_import = gfx.used_import )

pub struct AtlasBatch {
mut:
	bindings sg_bindings
	v_buffer_safe_to_update bool = true
	v_buffer_dirty bool
	verts []math.Vertex
	sprite_cnt int
	max_sprites int
	tex Texture
	quad math.Quad
}

pub fn atlasbatch(tex Texture, max_sprites int) &AtlasBatch {
	mut sb := &AtlasBatch{
		verts: utils.new_arr_with_default(max_sprites * 4, max_sprites * 4, math.Vertex{})
		max_sprites: max_sprites
		quad: math.quad(0, 0, 1, 1, tex.w, tex.h)
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
	sb.bindings.set_frag_image(0, tex.img)
	sb.tex = tex
}

pub fn (ab mut AtlasBatch) clear() {
	ab.sprite_cnt = 0
}

fn (ab &AtlasBatch) ensure_capacity() bool {
	if ab.sprite_cnt == ab.max_sprites {
		println('Error: sprite batch full. Aborting Add.')
		return false
	}
	return true
}

pub fn (ab mut AtlasBatch) set_q(index int, quad &math.Quad, matrix &math.Mat32, color &math.Color) {
	base_vert := index * 4

	matrix.transform_vec2_arr(&ab.verts[base_vert], &quad.positions[0], 4)

	for i in 0..4 {
		ab.verts[base_vert + i].s = quad.texcoords[i].x
		ab.verts[base_vert + i].t = quad.texcoords[i].y
		ab.verts[base_vert + i].color = *color
	}

	ab.v_buffer_dirty = true
}

pub fn (ab mut AtlasBatch) set(index int, config DrawConfig) {
	ab.quad.set_viewport(0, 0, ab.tex.w, ab.tex.h)
	ab.set_q(index, ab.quad, config.get_matrix(), config.color)
}

pub fn (sb mut AtlasBatch) add(config DrawConfig) int {
	if !sb.ensure_capacity() {
		return -1
	}

	sb.set(sb.sprite_cnt, config)

	sb.v_buffer_dirty = true
	sb.sprite_cnt++
	return sb.sprite_cnt - 1
}

pub fn (sb mut AtlasBatch) add_q(quad &math.Quad, config DrawConfig) int {
	if !sb.ensure_capacity() {
		return -1
	}

	sb.set_q(sb.sprite_cnt, quad, config.get_matrix(), config.color)

	sb.v_buffer_dirty = true
	sb.sprite_cnt++
	return sb.sprite_cnt - 1
}

pub fn (ab mut AtlasBatch) add_vp(viewport math.Rect, config DrawConfig) {
	ab.quad.set_viewport(viewport.x, viewport.y, viewport.w, viewport.h)
	ab.add_q(ab.quad, config)
}

pub fn (ab mut AtlasBatch) draw() {
	if ab.v_buffer_dirty {
		ab.update_verts()
	}

	sg_apply_bindings(&ab.bindings)
	sg_draw(0, ab.sprite_cnt * 6, 1)
	ab.v_buffer_safe_to_update = true
}

pub fn (ab &AtlasBatch) free() {
	ab.bindings.vertex_buffers[0].free()
	ab.bindings.index_buffer.free()

	unsafe {
		ab.verts.free()
		free(ab)
	}
}