module graphics
import via.libs.sokol.gfx

pub struct Mesh {
	vert_usage gfx.Usage
	indices_usage gfx.Usage
mut:
	bindings sg_bindings
	v_buffer_safe_to_update bool = true
	i_buffer_safe_to_update bool = true
pub mut:
	verts []Vertex
	indices []u16
}

pub fn mesh_create_dynamic(verts []Vertex, vert_usage gfx.Usage, indices []u16, indices_usage gfx.Usage) &Mesh {
	assert(vert_usage == .dynamic || vert_usage == .stream)
	assert(indices_usage == .dynamic || indices_usage == .stream)

	mut mesh := &Mesh{
		vert_usage: vert_usage
		indices_usage: indices_usage
		verts: verts.clone()
		indices: indices.clone()
	}

	mesh.bindings = bindings_create(mesh.verts, mesh.vert_usage, mesh.indices, mesh.indices_usage)
	mesh.update_verts()
	mesh.update_indices()

	return mesh
}

pub fn mesh_create_immutable(verts []Vertex, indices []u16) &Mesh {
	return &Mesh{
		vert_usage: .immutable
		indices_usage: .immutable
		verts: verts
		indices: indices
		bindings: bindings_create(verts, .immutable, indices, .immutable)
	}
}

// Mesh updates
pub fn (m mut Mesh) update_verts() {
	assert(m.vert_usage != .immutable)
	if m.v_buffer_safe_to_update {
		sg_update_buffer(m.bindings.vertex_buffers[0], m.verts.data, sizeof(Vertex) * m.verts.len)
		m.v_buffer_safe_to_update = false
	}
}

pub fn (m mut Mesh) update_indices() {
	assert(m.indices_usage != .immutable)
	if m.i_buffer_safe_to_update {
		sg_update_buffer(m.bindings.index_buffer, m.indices.data, sizeof(u16) * m.indices.len)
		m.i_buffer_safe_to_update = false
	}
}

pub fn (m mut Mesh) bind_image(image sg_image, index int) {
	m.bindings.fs_images[index] = image
}

// drawing
pub fn (m &Mesh) apply_bindings() {
	sg_apply_bindings(&m.bindings)
}

pub fn (m &Mesh) apply_uniforms(shader_stage gfx.ShaderStage, index int, data voidptr, num_bytes int) {
	sg_apply_uniforms(shader_stage, index, data, num_bytes)
}

pub fn (m mut Mesh) draw() {
	sg_draw(0, m.indices.len, 1)
	m.v_buffer_safe_to_update = true
	m.i_buffer_safe_to_update = true
}

[unsafe_fn]
pub fn (m &Mesh) free() {
	free(m.verts)
	free(m.indices)
	free(m)
}