module graphics
import via.math
import via.libs.sokol.gfx

pub struct SpriteBatch {
mut:
	bindings sg_bindings
	v_buffer_safe_to_update bool = true
	v_buffer_dirty bool
	verts []math.Vertex
	sprite_cnt int
	max_sprites int
	tex Texture
}

pub fn spritebatch_new(tex Texture, max_sprites int) &SpriteBatch {
	mut sb := &SpriteBatch{
		verts: [math.Vertex{math.Vec2{},math.Vec2{0,0},math.Color{}}].repeat(max_sprites * 4)
		max_sprites: max_sprites
	}

	indices := vert_quad_index_buffer_make(max_sprites)
	sb.bindings = bindings_create(sb.verts, .dynamic, indices, .immutable)
	sb.set_texture(tex)
	sb.update_verts()
	unsafe { indices.free() }

	return sb
}

// update methods
pub fn (sb mut SpriteBatch) update_verts() {
	if sb.v_buffer_safe_to_update {
		sg_update_buffer(sb.bindings.vertex_buffers[0], sb.verts.data, sizeof(math.Vertex) * sb.verts.len)
		sb.v_buffer_safe_to_update = false
		sb.v_buffer_dirty = false
	}
}

pub fn (sb mut SpriteBatch) set_texture(tex Texture) {
	sb.bindings.set_frag_image(0, tex.id)
	sb.tex = tex
}

pub fn (sb mut SpriteBatch) clear() {
	sb.sprite_cnt = 0
}

fn (sb &SpriteBatch) check_can_add() bool {
	if sb.sprite_cnt == sb.max_sprites {
		println('Error: sprite batch full. Aborting Add.')
		return false
	}
	return true
}

pub fn (sb mut SpriteBatch) set(index, x, y int) {
	mut base_vert := index * 4
	// tl
	sb.verts[base_vert].pos.x = x
	sb.verts[base_vert].pos.y = y
	sb.verts[base_vert].texcoords.x = 0
	sb.verts[base_vert].texcoords.y = 0
	// tr
	base_vert++
	sb.verts[base_vert].pos.x = x + sb.tex.width
	sb.verts[base_vert].pos.y = y
	sb.verts[base_vert].texcoords.x = 1
	sb.verts[base_vert].texcoords.y = 0
	// br
	base_vert++
	sb.verts[base_vert].pos.x = x + sb.tex.width
	sb.verts[base_vert].pos.y = y + sb.tex.height
	sb.verts[base_vert].texcoords.x = 1
	sb.verts[base_vert].texcoords.y = 1
	// bl
	base_vert++
	sb.verts[base_vert].pos.x = x
	sb.verts[base_vert].pos.y = y + sb.tex.height
	sb.verts[base_vert].texcoords.x = 0
	sb.verts[base_vert].texcoords.y = 1

	if index == 5 {
		mat := math.mat32_transform(x + 16, y + 16, math.radians(45), 1, 1, 16, 16)
		sb.verts[base_vert-3].pos = mat.transform_vec2(math.Vec2{0,0})
		sb.verts[base_vert-2].pos = mat.transform_vec2(math.Vec2{32,0})
		sb.verts[base_vert-1].pos = mat.transform_vec2(math.Vec2{32,32})
		sb.verts[base_vert].pos = mat.transform_vec2(math.Vec2{0,32})
	}

	sb.v_buffer_dirty = true
}

pub fn (sb mut SpriteBatch) set_q(index int) {
	mut base_vert := index * 4

	// matrix.transform_vec2_arr(&sb.verts[base_vert], &quad.vert_positions, 4)

	// for i in 0..4 {
	// 	sb.verts[base_vert + i].texcoords.x = quad.texcoords.x
	// 	sb.verts[base_vert + i].texcoords.y = quad.texcoords.y
	// }

	sb.v_buffer_dirty = true
}

pub fn (sb mut SpriteBatch) add(x, y int) int {
	if !sb.check_can_add() {
		return -1
	}

	sb.set(sb.sprite_cnt, x, y)

	sb.v_buffer_dirty = true
	sb.sprite_cnt++
	return sb.sprite_cnt - 1
}

pub fn (sb mut SpriteBatch) add_q() int {
	if !sb.check_can_add() {
		return -1
	}

	sb.set_q(sb.sprite_cnt)

	sb.v_buffer_dirty = true
	sb.sprite_cnt++
	return sb.sprite_cnt - 1
}

pub fn (sb mut SpriteBatch) draw(trans_mat &math.Mat44) {
	if sb.v_buffer_dirty {
		sb.update_verts()
	}

	sg_apply_bindings(&sb.bindings)
	sg_apply_uniforms(gfx.ShaderStage.vs, 0, trans_mat, sizeof(math.Mat44))
	sg_draw(0, sb.sprite_cnt * 6, 1)
	sb.v_buffer_safe_to_update = true
}

pub fn (sb &SpriteBatch) free() {
	sb.bindings.vertex_buffers[0].free()
	// sb.bindings.index_buffer.free() // V bug cant find sg_buffer
	sg_destroy_buffer(sb.bindings.index_buffer)

	unsafe {
		sb.verts.free()
		free(sb)
	}
}