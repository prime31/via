module posteffects
import via.graphics

// basic post effect that just takes a Pipeline and directly blits the source with it
pub struct Passthrough {
	pip graphics.Pipeline
}

pub fn passthrough(frag string) Passthrough {
	shader_desc := graphics.shader_get_default_desc()
	pip_desc := graphics.pipeline_get_default_desc()

	return Passthrough{
		pip: graphics.pipeline({frag:frag}, shader_desc, mut pip_desc)
	}
}

pub fn (p &Passthrough) free() {
	p.pip.free()
}

fn passthrough_process(vig &Passthrough, tex &graphics.Texture, stack &graphics.EffectStack) {
	stack.blit(tex, mut vig.pip)
}

pub fn (mut p &Passthrough) add_to_stack(stack graphics.EffectStack) {
	stack.add(p, passthrough_process)
}