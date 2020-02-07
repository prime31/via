module graphics
import via.time
import via.math
import via.window
import via.libs.sokol.gfx

pub struct FullscreenQuad {
mut:
	bindings sg_bindings
	verts []math.Vertex
	last_vert_update_frame u32
}

pub fn fullscreenquad() &FullscreenQuad {
	verts := [
		math.Vertex{0,0,	0,0,	math.Color{}}, // tl
		math.Vertex{0,0,	1,0,	math.Color{}}, // tr
		math.Vertex{0,0, 	1,1,	math.Color{}}, // br
		math.Vertex{0,0,	0,1,	math.Color{}}  // bl
	]!
	indices := [u16(0), 1, 2, 0, 2, 3]!

	mut mesh := &FullscreenQuad{
		verts: verts.clone()
	}

	mesh.bindings = bindings_create(mesh.verts, .dynamic, indices, .immutable)
	mesh.update_verts()

	return mesh
}

// updates the verts to match the current window drawable size
pub fn (q mut FullscreenQuad) update_verts() {
	if q.last_vert_update_frame < time.frame_count() {
		w, h := window.drawable_size()
		half_w := f32(w) / 2
		half_h := f32(h) / 2

		q.verts[0].x = -half_w	// tl
		q.verts[0].y = -half_h
		q.verts[1].x = half_w	// tr
		q.verts[1].y = -half_h
		q.verts[2].x = half_w	// br
		q.verts[2].y = half_h
		q.verts[3].x = -half_w	// bl
		q.verts[3].y = half_h

		sg_update_buffer(q.bindings.vertex_buffers[0], q.verts.data, sizeof(math.Vertex) * q.verts.len)
		q.last_vert_update_frame = time.frame_count()
	}
}

pub fn (q mut FullscreenQuad) bind_texture(index int, tex Texture) {
	q.bindings.set_frag_image(index, tex.img)
}

pub fn (q &FullscreenQuad) draw() {
	sg_apply_bindings(&q.bindings)
	sg_draw(0, 6, 1)
}

pub fn (q &FullscreenQuad) free() {
	q.bindings.vertex_buffers[0].free()
	q.bindings.index_buffer.free()

	unsafe {
		q.verts.free()
		free(q)
	}
}