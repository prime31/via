module graphics
import via.libs.sokol.gfx

pub fn shader_make(shader_def &ShaderDef) C.sg_shader {
	shader_desc := C.sg_shader_desc{
		vs: vert_desc_make(shader_def)
		fs: frag_desc_make(shader_def)
	}
	return sg_make_shader(&shader_desc)
}

pub fn shader_make_default() C.sg_shader {
	mut def := ShaderDef{}
	def.apply_defaults()

	shader := shader_make(&def)
	def.free()
	return shader
}

pub fn vert_desc_make(shader_def &ShaderDef) C.sg_shader_stage_desc {
	mut vs_desc := sg_shader_stage_desc{
		source: shader_def.get_vert()
	}

	for i, u_block in shader_def.uniform_blocks {
		if u_block.size == 0 { break }

		vs_desc.uniform_blocks[i].size = u_block.size
		for j, uniform in u_block.uniforms {
			vs_desc.uniform_blocks[i].uniforms[j] = sg_shader_uniform_desc{
				name: uniform.name.str
				@type: uniform.@type
			}
		}
	}

	for i, img in shader_def.vert_images {
		vs_desc.images[i] = sg_shader_image_desc{
			name: img.str
			@type: ._2d
		}
	}
	return vs_desc
}

pub fn frag_desc_make(shader_def &ShaderDef) C.sg_shader_stage_desc {
	mut fs_desc := sg_shader_stage_desc{
		source: shader_def.get_frag()
	}

	for i, img in shader_def.frag_images {
		fs_desc.images[i] = sg_shader_image_desc{
			name: img.str
			@type: ._2d
		}
	}

	return fs_desc
}