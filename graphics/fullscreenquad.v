module graphics
import via.time
import via.math
import via.libs.sokol.gfx

pub struct FullscreenQuad {
mut:
	bindings sg_bindings
	verts []math.Vertex
	last_vert_update_frame u32
	width int
	height int
}

// FullscreenQuad keeps itself sized for the DefaultOffScreenPass rendering. It is used for blitting back and forth
// between offscreen passes when applying post processing.
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
		scaler := get_resolution_scaler()
		if scaler.w != q.width || scaler.h != q.height {
			q.verts[0].x = 0	// tl
			q.verts[0].y = 0
			q.verts[1].x = scaler.w	// tr
			q.verts[1].y = 0
			q.verts[2].x = scaler.w	// br
			q.verts[2].y = scaler.h
			q.verts[3].x = 0	// bl
			q.verts[3].y = scaler.h

			sg_update_buffer(q.bindings.vertex_buffers[0], q.verts.data, sizeof(math.Vertex) * q.verts.len)
			q.last_vert_update_frame = time.frame_count()
			q.width = scaler.w
			q.height = scaler.h
		}
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