module graphics
import via.libs.sokol.gfx

fn C.memcmp() int

pub struct Pipeline {
mut:
	uniforms []UniformBlock
pub:
	pip C.sg_pipeline
	shader C.sg_shader
}

struct UniformBlock {
mut:
	shader_stage gfx.ShaderStage
	index int
	num_bytes int
	data voidptr
	dirty bool
}

pub fn (p1 &Pipeline) eq(p2 &Pipeline) bool {
	return p1.shader.id == p2.shader.id && p1.pip.id == p2.pip.id
}

pub fn (p &Pipeline) free() {
	for u in p.uniforms {
		unsafe { free(u.data) }
	}
	unsafe { p.uniforms.free() }
	p.pip.free()
	p.shader.free()
}

pub fn pipeline(shader_src ShaderSourceConfig, shader_desc sg_shader_desc, pipeline_desc mut sg_pipeline_desc) Pipeline {
	pipeline_desc.shader = shader_make(shader_src, mut shader_desc)

	mut uniforms := []UniformBlock
	for i in 0..4 {
		u := shader_desc.vs.uniform_blocks[i]
		if u.size == 0 { break }

		unsafe {
			uniforms << UniformBlock{
				shader_stage: .vs
				index: i
				num_bytes: u.size
				data: malloc(u.size)
			}
		}
	}

	for i in 0..4 {
		u := shader_desc.fs.uniform_blocks[i]
		if u.size == 0 { break }

		unsafe {
			uniforms << UniformBlock{
				shader_stage: .fs
				index: i
				num_bytes: u.size
				data: malloc(u.size)
			}
		}
	}

	return Pipeline{
		uniforms: uniforms
		pip: sg_make_pipeline(pipeline_desc)
		shader: pipeline_desc.shader
	}
}

pub fn pipeline_new_default() Pipeline {
	shader_desc := shader_get_default_desc()
	mut pipeline_desc := pipeline_get_default_desc()
	pipeline_desc.label = 'Default Pip'.str
	return pipeline({}, shader_desc, mut pipeline_desc)
}

pub fn pipeline_new_default_text() Pipeline {
	shader_desc := shader_get_default_desc()
	mut pipeline_desc := pipeline_get_default_desc()
	pipeline_desc.label = 'Default Text Pip'.str

	mut frag_main := string{0, 0}
	$if metal? { frag_main = default_text_frag_main_metal }
	$if !metal? { frag_main = default_text_frag_main }
	return pipeline({frag: frag_main}, shader_desc, mut pipeline_desc)
}

pub fn (p &Pipeline) get_uniform_index(shader_stage gfx.ShaderStage, index int) int {
	for i, uni in p.uniforms {
		if uni.shader_stage == int(shader_stage) && uni.index == index {
			return i
		}
	}
	return -1
}

pub fn (mut p Pipeline) set_uniform(uniform_index int, data voidptr) {
	assert(uniform_index >= 0 && uniform_index < p.uniforms.len)

	mut uni := p.uniforms[uniform_index]
	// only set and dirty the uniform if it changed
	if C.memcmp(data, uni.data, uni.num_bytes) != 0 {
		p.uniforms[uniform_index].dirty = true
		C.memcpy(uni.data, data, uni.num_bytes)
	}
}

pub fn (mut p Pipeline) set_uniform_raw(shader_stage gfx.ShaderStage, index int, data voidptr) {
	uni_index := p.get_uniform_index(shader_stage, index)
	assert(uni_index >= 0)
	p.set_uniform(uni_index, data)
}

pub fn (mut p Pipeline) apply_uniforms() {
	for i, uni in p.uniforms {
		if uni.dirty {
			sg_apply_uniforms(uni.shader_stage, uni.index, uni.data, uni.num_bytes)
			p.uniforms[i].dirty = false
		}
	}
}