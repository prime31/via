module posteffects
import via.time
import via.graphics

const (
	frag_noise = '
	uniform float _time = 0.0;
	uniform float _power = 50.0;

	float rand(vec2 co){
		return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
	}

	vec4 effect(vec4 vcolor, sampler2D tex, vec2 texcoord) {
		vec4 color = texture(tex, texcoord);
		float x = (texcoord.x + 4) * (texcoord.y + 4) * (sin(_time) * 10);
		vec3 grain = vec3(mod((mod(x, 13) + 1) * (mod(x, 123) + 1), 0.01) - 0.005) * _power;
		color.rgb += grain;

		return color;
	}'
)

pub struct Noise {
	pip graphics.Pipeline
	power_index int
	time_index int
pub mut:
	power f32 = 50.0
}

pub fn noise() Noise {
	mut shader_desc := graphics.shader_get_default_desc()
	shader_desc.set_frag_uniform_block_size(0, sizeof(f32))
		.set_frag_uniform(0, 0, '_time', .float, 0)
		.set_frag_uniform_block_size(1, sizeof(f32))
		.set_frag_uniform(1, 0, '_power', .float, 0)
	pip_desc := graphics.pipeline_get_default_desc()
	pip := graphics.pipeline({frag:frag_noise}, shader_desc, mut pip_desc)

	mut n := Noise{
		pip: pip
		time_index: pip.get_uniform_index(.fs, 0)
		power_index: pip.get_uniform_index(.fs, 1)
	}

	// set defaults
	n.set_power(n.power)

	return n
}

pub fn (n &Noise) free() {
	n.pip.free()
}

fn noise_process(n mut Noise, tex &graphics.Texture, stack &graphics.EffectStack) {
	time := time.seconds()
	n.pip.set_uniform(n.time_index, &time)
	stack.blit(tex, mut n.pip)
}

pub fn (n &Noise) add_to_stack(stack mut graphics.EffectStack) {
	stack.add(n, noise_process)
}

pub fn (n mut Noise) set_power(power f32) {
	n.power = power
	n.pip.set_uniform(n.power_index, &n.power)
}

pub fn (n mut Noise) imgui() {
	C.igText(c'Noise')
	if C.igDragFloat(c'Power', &n.power, 0.1, 0.01, 150.0, C.NULL, 1) {
		n.set_power(n.power)
	}
}