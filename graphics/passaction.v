module graphics
import via.math
import via.libs.sokol.gfx

pub struct PassAction {
pub mut:
	pass C.sg_pass_action
}

pub struct PassActionConfig {
pub:
	color math.Color = math.Color{}
	color_action gfx.Action = gfx.Action.clear
	stencil_action gfx.Action = .clear
	stencil_val byte = byte(0)
}

pub fn passaction(config PassActionConfig) PassAction {
	mut color_action := sg_color_attachment_action {
		action: config.color_action
	}
	color_action.set_color_values(config.color.r_f(), config.color.g_f(), config.color.b_f(), config.color.a_f())

	mut pass_action := sg_pass_action{
		stencil: sg_stencil_attachment_action{
			action: config.stencil_action
			val: config.stencil_val
		}
	}
	pass_action.colors[0] = color_action

	return PassAction{pass_action}
}

pub fn (p mut PassAction) set_depth_action(action gfx.Action, val f32) {
	p.pass.depth = sg_depth_attachment_action{
		action: action
		val: val
	}
}

pub fn (p mut PassAction) set_stencil_action(action gfx.Action, val byte) {
	p.pass.stencil = sg_stencil_attachment_action{
		action: action
		val: val
	}
}