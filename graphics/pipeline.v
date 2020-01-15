module graphics
import via.math
import via.libs.sokol.gfx

pub fn pipeline_make_default() sg_pipeline {
	mut shader_desc := shader_get_default_desc()
	shader := shader_make(null_str, null_str, mut shader_desc)

	pipeline_desc := pipeline_desc_make_default(shader)
	return sg_make_pipeline(&pipeline_desc)
}

pub fn pipeline_desc_make_default(shader sg_shader) sg_pipeline_desc {
	return sg_pipeline_desc{
		layout: layout_desc_make_default()
		shader: shader
		index_type: .uint16
		blend: sg_blend_state{
			enabled: true
			src_factor_rgb: .src_alpha
			dst_factor_rgb: .one_minus_src_alpha
			src_factor_alpha: .one
			dst_factor_alpha: .one_minus_src_alpha
		}
	}
}

pub fn layout_desc_make_default() sg_layout_desc {
	mut layout := sg_layout_desc{}
	layout.attrs[0] = sg_vertex_attr_desc{
		format: .float2 // position
	}
	layout.attrs[1] = sg_vertex_attr_desc{
		format: .float2 // tex coords
	}
	layout.attrs[2] = sg_vertex_attr_desc{
		format: .ubyte4n // color
	}
	return layout
}

pub fn bindings_create(verts []math.Vertex, vert_usage gfx.Usage, indices []u16, indices_usage gfx.Usage) sg_bindings {
	mut bindings := sg_bindings{}
	bindings.vertex_buffers[0] = vert_buffer_create(verts, vert_usage)
	bindings.index_buffer = index_buffer_create(indices, indices_usage)
	return bindings
}

pub fn vert_buffer_create(verts []math.Vertex, usage gfx.Usage) sg_buffer {
	mut vert_buff_desc := sg_buffer_desc{
		@type: .vertexbuffer
		usage: usage
		size: sizeof(math.Vertex) * verts.len
	}

	// dynamic and stream needs to be set some time after init
	if usage != .dynamic && usage != .stream {
		vert_buff_desc.content = verts.data
	}
	return sg_make_buffer(&vert_buff_desc)
}

pub fn index_buffer_create(indices []u16, usage gfx.Usage) sg_buffer {
	mut index_buff_desc := sg_buffer_desc{
		@type: .indexbuffer
		usage: usage
		size: sizeof(u16) * indices.len
	}

	// dynamic and stream needs to be set some time after init
	if usage != .dynamic && usage != .stream {
		index_buff_desc.content = indices.data
	}
	return sg_make_buffer(&index_buff_desc)
}