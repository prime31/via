module graphics
import via.math
import via.libs.sokol.gfx
import os

pub struct ShaderDef {
pub mut:
	vert string
	frag string
	vert_images []string
	frag_images []string
	uniform_blocks []ShaderUniformBlockDef
}

pub struct ShaderUniformBlockDef {
pub mut:
	size int
	uniforms []ShaderUniformDef
}

pub struct ShaderUniformDef {
pub mut:
	name string
	@type gfx.UniformType
	array_count int
}

pub fn (sd mut ShaderDef) apply_defaults() {
	sd.frag_images << 'MainTex'

	sd.uniform_blocks << ShaderUniformBlockDef{
		size: sizeof(math.Mat44)
	}

	sd.uniform_blocks[0].uniforms << ShaderUniformDef {
		name: 'TransformProjectionMatrix'
		@type: .mat4
	}
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