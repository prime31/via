module graphics
import via.math
import via.libs.sokol.gfx

pub const (
	null_str = string{0, 0}
)

pub fn shader_make(vert, frag string, shader_desc mut sg_shader_desc) C.sg_shader {
	vert_main := if vert.len == 0 { default_vert_main } else { vert }
	frag_main := if frag.len == 0 { default_frag_main } else { frag }

	mut vert_src := default_vert + vert_main
	frag_src := default_frag + frag_main

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
	}
	shader_desc.set_frag_image(0, 'MainTex')
		.set_vert_uniform_block_size(0, sizeof(math.Mat44))
		.set_vert_uniform(0, 0, 'TransformProjectionMatrix', .mat4, 0)
	return shader_desc
}