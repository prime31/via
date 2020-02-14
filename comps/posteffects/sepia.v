module posteffects
import via.math
import via.graphics

const (
	frag_sepia = '
	uniform vec3 _sepia_tone = vec3(1.2, 1.0, 0.8);

	vec4 effect(vec4 vcolor, sampler2D tex, vec2 texcoord) {
		vec4 color = texture(tex, texcoord);

		// first we need to convert to greyscale
		float gray_scale = dot(color.rgb, vec3(0.3, 0.59, 0.11));
		color.rgb = mix(color.rgb, gray_scale * _sepia_tone, 0.75);

		return color;
	}'
)

pub struct Sepia {
	pip graphics.Pipeline
	tone_index int
pub mut:
	tone math.Vec3 = math.Vec3{1.2, 1.0, 0.8}
}

pub fn sepia() Sepia {
	mut shader_desc := graphics.shader_get_default_desc()
	shader_desc.set_frag_uniform_block_size(0, sizeof(math.Vec3))
		.set_frag_uniform(0, 0, '_sepia_tone', .float3, 0)
	pip_desc := graphics.pipeline_get_default_desc()
	pip := graphics.pipeline({frag:frag_sepia}, shader_desc, mut pip_desc)

	mut s := Sepia{
		pip: pip
		tone_index: pip.get_uniform_index(.fs, 0)
	}

	// set defaults
	s.set_tone(s.tone)

	return s
}

pub fn (s &Sepia) free() {
	s.pip.free()
}

fn sepia_process(s &Sepia, tex &graphics.Texture, stack &graphics.EffectStack) {
	stack.blit(tex, mut s.pip)
}

pub fn (s &Sepia) add_to_stack(stack mut graphics.EffectStack) {
	stack.add(s, sepia_process)
}

pub fn (s mut Sepia) set_tone(tone math.Vec3) {
	s.tone = tone
	s.pip.set_uniform(s.tone_index, &s.tone)
}

pub fn (s mut Sepia) imgui() {
	C.igText(c'Sepia')
	if C.igDragFloat3(c'Tone', &s.tone, 0.01, 0, 2.0, C.NULL, 1) {
		s.set_tone(s.tone)
	}
}