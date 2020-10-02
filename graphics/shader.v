module graphics
import via.math
import via.libs.sokol.gfx

pub const ( shd_import = gfx.used_import )

pub struct ShaderSourceConfig {
pub:
	vert string = string{0, 0}
	frag string = string{0, 0}
}

pub fn shader_make(src ShaderSourceConfig, mut shader_desc sg_shader_desc) C.sg_shader {
	mut vert_main := string{0, 0}
	mut frag_main := string{0, 0}

	$if metal? {
		vert_main = if src.vert.len == 0 { default_vert_main_metal } else { src.vert }
		frag_main = if src.frag.len == 0 { default_frag_main_metal } else { src.frag }
	}

	$if !metal? {
		vert_main = if src.vert.len == 0 { default_vert_main } else { src.vert }
		frag_main = if src.frag.len == 0 { default_frag_main } else { src.frag }
	}

	mut vert_src := string{0, 0}
	mut frag_src := string{0, 0}

	$if metal? {
		vert_src = default_vert_metal + vert_main
		frag_src = default_frag_metal + frag_main
	}

	$if !metal? {
		vert_src = default_vert + vert_main
		frag_src = default_frag + frag_main
	}

	shader := shader_desc.set_vert_src(vert_src)
		.set_frag_src(frag_src)
		.make_shader()

	vert_src.free()
	frag_src.free()

	return shader
}

// returns a sg_shader_desc with the default frag texture and vert uniform block
pub fn shader_get_default_desc() C.sg_shader_desc {
	mut shader_desc := C.sg_shader_desc{
		_start_canary: 0 // hack because struct initialization fails if something isnt set
		label: &byte(0)
	}
	shader_desc.set_frag_image(0, 'MainTex')
		.set_vert_uniform_block_size(0, sizeof(math.Mat32))
		.set_vert_uniform(0, 0, 'TransformMatrix', .float3, 2)
	return shader_desc
}