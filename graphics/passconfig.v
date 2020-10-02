module graphics
import via.math
import via.libs.sokol.gfx

pub struct PassConfig {
pub:
	color math.Color = math.Color{}
	color_action gfx.Action = gfx.Action.clear
	stencil_action gfx.Action = .clear
	stencil byte = byte(0)

	trans_mat &math.Mat32 = &math.Mat32(0)
	pipeline &Pipeline
	pass &OffScreenPass
}

fn (mut cfg PassConfig) apply(mut pa C.sg_pass_action) {
	pa.colors[0].action = cfg.color_action
	pa.colors[0].val[0] = cfg.color.r_f()
	pa.colors[0].val[1] = cfg.color.g_f()
	pa.colors[0].val[2] = cfg.color.b_f()
	pa.colors[0].val[3] = cfg.color.a_f()

	pa.stencil.action = cfg.stencil_action
	pa.stencil.val = cfg.stencil
}
