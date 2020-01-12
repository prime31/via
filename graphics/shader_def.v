module graphics
import via.math
import via.libs.sokol.gfx
import os

pub struct ShaderDef {
mut:
	vert string
	frag string
	vert_images []string
	frag_images []string
	uniform_blocks []ShaderUniformBlockDef
}

struct ShaderUniformBlockDef {
mut:
	size int
	uniforms []ShaderUniformDef
}

struct ShaderUniformDef {
mut:
	name string
	@type gfx.UniformType
	array_count int
}

pub fn (sd mut ShaderDef) add_vert_image(name string) &ShaderDef {
	sd.vert_images << name
	return sd
}

pub fn (sd mut ShaderDef) add_frag_image(name string) &ShaderDef {
	sd.frag_images << name
	return sd
}

pub fn (sd mut ShaderDef) add_uniform_block(size int) &ShaderDef {
	sd.uniform_blocks << ShaderUniformBlockDef{
		size: size
	}
	return sd
}

pub fn (sd mut ShaderDef) set_uniform(block_index int, name string, @type gfx.UniformType, array_count int) &ShaderDef {
	assert(sd.uniform_blocks.len > block_index)
	sd.uniform_blocks[block_index].uniforms << ShaderUniformDef{
		name: name
		@type: @type
	}
	return sd
}

pub fn (sd mut ShaderDef) apply_defaults() &ShaderDef {
	sd.add_frag_image('MainTex')
		.add_uniform_block(sizeof(math.Mat44))
		.set_uniform(0, 'TransformProjectionMatrix', .mat4, 0)
	return sd
}

fn (sd &ShaderDef) get_vert() byteptr {
	// no vert shader so use default
	if sd.vert.len == 0 { return (default_vert + default_vert_main).str }

	// shader is from a file
	if sd.vert.ends_with('.vert') {
		vert_shader := os.read_file(sd.vert) or { panic('vert shader not found: $sd.vert') }
		return (default_vert + vert_shader).str
	}

	// raw shader string
	assert(sd.vert.contains('position('))
	return (default_vert + sd.vert).str
}

fn (sd &ShaderDef) get_frag() byteptr {
	// no frag shader so use default
	if sd.frag.len == 0 { return (default_frag + default_frag_main).str }

	// shader is from a file
	if sd.frag.ends_with('.vert') {
		frag_shader := os.read_file(sd.frag) or { panic('frag shader not found: $sd.frag') }
		return (default_frag + frag_shader).str
	}

	// raw shader string
	assert(sd.frag.contains('effect('))
	return (default_frag + sd.frag).str
}

fn (sd &ShaderDef) free() {
	unsafe {
		for block in sd.uniform_blocks {
			block.uniforms.free()
		}

		if sd.vert.len > 0 { sd.vert.free() }
		if sd.frag.len > 0 { sd.frag.free() }
		sd.vert_images.free()
		sd.frag_images.free()
		sd.uniform_blocks.free()
	}
}