module graphics
import via.math
import via.window

pub enum ResolutionPolicy {
	default
	no_border
	no_border_pixel_perfect
	show_all
	show_all_pixel_perfect
	best_fit
}

pub struct ResolutionScaler {
pub:
	x int
	y int
	w int
	h int
	scale f32 = 1.0
}

pub fn (policy ResolutionPolicy) get_scaler(design_w, design_h int) ResolutionScaler {
	// non-default policy requires a design size
	assert (policy != .default && design_w > 0 && design_h > 0) || (policy == .default)

	// common config
	w, h := window.drawable_size()

	// our render target size will be full screen for .default
	rt_w := if policy == .default { w } else { design_w }
	rt_h := if policy == .default { h } else { design_h }

	// scale of the screen size / render target size, used by both pixel perfect and non-pp
	res_x := f32(w) / rt_w
	res_y := f32(h) / rt_h

	mut scale := 1
	mut scale_f := 1.0
	aspect_ratio := f32(w) / f32(h)
	rt_aspect_ratio := f32(rt_w) / f32(rt_h)

	if policy != .default {
		scale_f = if rt_aspect_ratio > aspect_ratio { res_x } else { res_y }
		scale = math.ifloor(f32(scale_f))
		if scale < 1 {
			scale = 1
		}
	}

	match policy {
		.default {
			win_scale := window.scale()
			width := int(f32(w) / win_scale)
			height := int(f32(h) / win_scale)
			return ResolutionScaler{w:width h:height scale:win_scale}
		}
		.no_border, .show_all {
			res_scale := if policy == .no_border {
				// go for the highest scale value since we can crop
				math.max(res_x, res_y)
			} else {
				// go for the lowest scale value so everything fits properly
				math.min(res_x, res_y)
			}

			x := (f32(w) - (f32(rt_w) * res_scale)) / 2.0
			y := (f32(h) - (f32(rt_h) * res_scale)) / 2.0

			return ResolutionScaler{x:int(x) y:int(y) w:rt_w h:rt_h scale:res_scale}
		}
		.no_border_pixel_perfect, .show_all_pixel_perfect {
			// the only difference is that no_border rounds up (instead of down) and crops. Because
			// of the round up, we flip the compare of the rt aspect ratio vs the screen aspect ratio.
			if policy == .no_border_pixel_perfect {
				scale_f = if rt_aspect_ratio < aspect_ratio { res_x } else { res_y }
				scale = math.iceil(f32(scale_f))
			}

			x := (w - (rt_w * scale)) / 2
			y := (h - (rt_h * scale)) / 2
			return ResolutionScaler{x:x y:y w:rt_w h:rt_h scale:scale}
		}
		.best_fit {
			// TODO: move this into some sort of safe area config
			bleed_x := 0
			bleed_y := 0
			safe_sx := f32(w) / (rt_w - bleed_x)
			safe_sy := f32(h) / (rt_h - bleed_y)

			res_scale := math.max(res_x, res_y)
			safe_scale := math.min(safe_sx, safe_sy)
			final_scale := math.min(res_scale, safe_scale)

			x := (f32(w) - (f32(rt_w) * final_scale)) / 2.0
			y := (f32(h) - (f32(rt_h) * final_scale)) / 2.0

			return ResolutionScaler{x:int(x) y:int(y) w:rt_w h:rt_h scale:final_scale}
		}
		//else { return ResolutionScaler{} }
	}
}
