module posteffects
import via.graphics

const (
	frag_vignette = '
	uniform float _radius = 1.25;
	uniform float _power = 1.0;

	vec4 effect(vec4 vcolor, sampler2D tex, vec2 texcoord) {
		vec4 color = texture(tex, texcoord);

		vec2 dist = (texcoord - 0.5f) * _radius;
		dist.x = 1 - dot(dist, dist) * _power;
		color.rgb *= dist.x;

		return color;
	}'
)

pub struct Vignette {
	pip graphics.Pipeline
	radius_index int
	power_index int
pub mut:
	radius f32 = 1.25
	power f32 = 1.0
}

pub fn vignette() Vignette {
	mut shader_desc := graphics.shader_get_default_desc()
	shader_desc.set_frag_uniform_block_size(0, sizeof(f32))
		.set_frag_uniform(0, 0, '_radius', .float, 0)
		.set_frag_uniform_block_size(1, sizeof(f32))
		.set_frag_uniform(1, 0, '_power', .float, 0)
	pip_desc := graphics.pipeline_get_default_desc()
	pip := graphics.pipeline({frag:frag_vignette}, shader_desc, mut pip_desc)

	mut vig := Vignette{
		pip: pip
		radius_index: pip.get_uniform_index(.fs, 0)
		power_index: pip.get_uniform_index(.fs, 1)
	}

	// set defaults
	vig.set_radius(vig.radius)
	vig.set_power(vig.power)

	return vig
}

pub fn (vig &Vignette) free() {
	vig.pip.free()
}

fn vignette_process(vig &Vignette, tex &graphics.Texture, stack &graphics.EffectStack) {
	stack.blit(tex, mut vig.pip)
}

pub fn (vig &Vignette) add_to_stack(stack mut graphics.EffectStack) {
	stack.add(vig, vignette_process)
}

pub fn (vig mut Vignette) set_radius(radius f32) {
	vig.radius = radius
	vig.pip.set_uniform(vig.radius_index, &vig.radius)
}

pub fn (vig mut Vignette) set_power(power f32) {
	vig.power = power
	vig.pip.set_uniform(vig.power_index, &vig.power)
}

pub fn (vig mut Vignette) imgui() {
	C.igText(c'Vignette')
	if C.igDragFloat(c'Vignette Radius', &vig.radius, 0.01, 0.01, 5.0, C.NULL, 1) {
		vig.set_radius(vig.radius)
	}

	if C.igDragFloat(c'Vignette Poser', &vig.power, 0.01, 0.01, 5.0, C.NULL, 1) {
		vig.set_power(vig.power)
	}
}