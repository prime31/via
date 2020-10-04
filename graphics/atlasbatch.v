module graphics
import via.math
import via.utils
import via.libs.sokol.gfx

pub const ( used_import = gfx.used_import )

// note: does not free the Textures
pub struct AtlasBatch {
mut:
	bindings C.sg_bindings
	v_buffer_safe_to_update bool = true
	v_buffer_dirty bool
	verts []math.Vertex
	sprite_cnt int
	max_sprites int
	tex Texture
	quad math.Quad
}

pub fn atlasbatch(tex Texture, max_sprites int) &AtlasBatch {
	arr := []math.Vertex{len: max_sprites * 4, cap: max_sprites * 4, init: math.Vertex{}}
	//utils.new_arr_with_default<math.Vertex>(max_sprites * 4, max_sprites * 4, math.Vertex{})

	mut sb := &AtlasBatch{
		verts: arr
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

pub fn (ab &AtlasBatch) free() {
	ab.bindings.vertex_buffers[0].free()
	ab.bindings.index_buffer.free()

	unsafe {
		ab.verts.free()
		C.free(ab)
	}
}

pub fn (mut sb AtlasBatch) update_verts() {
	if sb.v_buffer_safe_to_update {
		C.sg_update_buffer(sb.bindings.vertex_buffers[0], sb.verts.data, sizeof(math.Vertex) * u32(sb.verts.len))
		sb.v_buffer_safe_to_update = false
		sb.v_buffer_dirty = false
	}
}

pub fn (mut sb AtlasBatch) set_texture(tex Texture) {
	sb.bindings.set_frag_image(0, tex.img)
	sb.tex = tex
}

pub fn (mut ab AtlasBatch) clear() {
	ab.sprite_cnt = 0
}

fn (ab &AtlasBatch) ensure_capacity() bool {
	if ab.sprite_cnt == ab.max_sprites {
		println('Error: sprite batch full. Aborting Add.')
		return false
	}
	return true
}

//#region updating quads

pub fn (mut ab AtlasBatch) set_q(index int, quad &math.Quad, matrix &math.Mat32, color &math.Color) {
	base_vert := index * 4

	matrix.transform_vec2_arr(&ab.verts[base_vert], &quad.positions[0], 4)

	for i in 0..4 {
		ab.verts[base_vert + i].s = quad.texcoords[i].x
		ab.verts[base_vert + i].t = quad.texcoords[i].y
		ab.verts[base_vert + i].color = *color
	}

	ab.v_buffer_dirty = true
}

pub fn (mut ab AtlasBatch) set_vp(index int, viewport math.Rect, config DrawConfig) {
	ab.quad.set_viewport(viewport.x, viewport.y, viewport.w, viewport.h)
	quad := ab.quad
	mat := config.get_matrix()
	ab.set_q(index, quad, mat, config.color)
}

pub fn (mut ab AtlasBatch) set(index int, config DrawConfig) {
	ab.quad.set_viewport(0, 0, ab.tex.w, ab.tex.h)
	quad := ab.quad
	mat := config.get_matrix()
	ab.set_q(index, quad, mat, config.color)
}

//#endregion

//#region adding quads

pub fn (mut sb AtlasBatch) add_q(quad &math.Quad, config DrawConfig) int {
	if !sb.ensure_capacity() {
		return -1
	}

	mat := config.get_matrix()
	sb.set_q(sb.sprite_cnt, quad, mat, config.color)

	sb.v_buffer_dirty = true
	sb.sprite_cnt++
	return sb.sprite_cnt - 1
}

pub fn (mut ab AtlasBatch) add_vp(viewport math.Rect, config DrawConfig) {
	ab.quad.set_viewport(viewport.x, viewport.y, viewport.w, viewport.h)
	ab.add_q(ab.quad, config)
}

pub fn (mut sb AtlasBatch) add(config DrawConfig) int {
	if !sb.ensure_capacity() {
		return -1
	}

	sb.set(sb.sprite_cnt, config)

	sb.v_buffer_dirty = true
	sb.sprite_cnt++
	return sb.sprite_cnt - 1
}

//#endregion

pub fn (mut ab AtlasBatch) draw() {
	if ab.v_buffer_dirty {
		ab.update_verts()
	}

	C.sg_apply_bindings(&ab.bindings)
	C.sg_draw(0, ab.sprite_cnt * 6, 1)
	ab.v_buffer_safe_to_update = true
}
