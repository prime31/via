module graphics
import via.libs.sokol.gfx

pub struct GraphicsConfig {
	resolution_policy ResolutionPolicy
	design_width int
	design_height int
	max_quads int
	max_tris int
	min_filter gfx.Filter
	mag_filter gfx.Filter
}