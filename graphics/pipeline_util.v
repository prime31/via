module graphics
import via.math
import via.libs.sokol.gfx

pub fn pipeline_make_default() (C.sg_pipeline, C.sg_shader) {
	mut shader_desc := shader_get_default_desc()
	shader := shader_make({}, mut shader_desc)

	mut pipeline_desc := pipeline_desc_make_default(shader)
	pipeline_desc.label = 'Default Pip'.str
	return C.sg_make_pipeline(&pipeline_desc), shader
}

pub fn pipeline_make_default_text() (C.sg_pipeline, C.sg_shader) {
	mut shader_desc := shader_get_default_desc()
	shader := shader_make({frag: default_text_frag_main}, mut shader_desc)

	mut pipeline_desc := pipeline_desc_make_default(shader)
	pipeline_desc.label = 'Default Text Pip'.str
	return C.sg_make_pipeline(&pipeline_desc), shader
}

pub fn pipeline_desc_make_default(shader C.sg_shader) C.sg_pipeline_desc {
	mut desc := pipeline_get_default_desc()
	desc.shader = shader
	return desc
}

pub fn pipeline_get_default_desc() C.sg_pipeline_desc {
	return C.sg_pipeline_desc{
		layout: layout_desc_make_default()
		index_type: .uint16
		label: &byte(0)
		blend: C.sg_blend_state{
			enabled: true
			src_factor_rgb: .src_alpha
			dst_factor_rgb: .one_minus_src_alpha
			src_factor_alpha: .one
			dst_factor_alpha: .one_minus_src_alpha
		}
	}
}

pub fn layout_desc_make_default() C.sg_layout_desc {
	mut layout := C.sg_layout_desc{}
	layout.attrs[0] = C.sg_vertex_attr_desc{
		format: .float2 // position
	}
	layout.attrs[1] = C.sg_vertex_attr_desc{
		format: .float2 // tex coords
	}
	layout.attrs[2] = C.sg_vertex_attr_desc{
		format: .ubyte4n // color
	}
	return layout
}

pub fn bindings_create(verts []math.Vertex, vert_usage gfx.Usage, indices []u16, indices_usage gfx.Usage) C.sg_bindings {
	mut bindings := C.sg_bindings{}
	bindings.vertex_buffers[0] = vert_buffer_create(verts, vert_usage)
	bindings.index_buffer = index_buffer_create(indices, indices_usage)
	return bindings
}

pub fn vert_buffer_create(verts []math.Vertex, usage gfx.Usage) C.sg_buffer {
	mut vert_buff_desc := C.sg_buffer_desc{
		@type: .vertexbuffer
		usage: usage
		size: int(sizeof(math.Vertex) * u32(verts.len))
		label: &byte(0)
		d3d11_buffer: 0
		content: 0
	}

	// dynamic and stream needs to be set some time after init
	if usage != .dynamic && usage != .stream {
		vert_buff_desc.content = verts.data
	}
	return C.sg_make_buffer(&vert_buff_desc)
}

pub fn index_buffer_create(indices []u16, usage gfx.Usage) C.sg_buffer {
	mut index_buff_desc := C.sg_buffer_desc{
		@type: .indexbuffer
		usage: usage
		size: int(sizeof(u16) * u32(indices.len))
		label: &byte(0)
		d3d11_buffer: 0
		content: 0
	}

	// dynamic and stream needs to be set some time after init
	if usage != .dynamic && usage != .stream {
		index_buff_desc.content = indices.data
	}
	return C.sg_make_buffer(&index_buff_desc)
}