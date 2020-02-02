module graphics
import via.math
import via.window
import via.libs.sokol.gfx

pub struct OffScreenPass{
pub:
	color_tex Texture
	depth_tex Texture
	pass sg_pass
}

pub fn offscreenpass(width, height int, min_filter gfx.Filter, mag_filter gfx.Filter) OffScreenPass {
	color_tex := rendertexture(width, height, min_filter, mag_filter, false)
	depth_tex := rendertexture(width, height, min_filter, mag_filter, true)

	// create an offscreen render pass into those images
	mut pass_desc := sg_pass_desc{
		label: 'Offscreen Pass'.str
	}
	pass_desc.color_attachments[0].image = color_tex.img
	pass_desc.depth_stencil_attachment.image = depth_tex.img

	return OffScreenPass{
		color_tex: color_tex
		depth_tex: depth_tex
		pass: sg_make_pass(&pass_desc)
	}
}

pub fn (p &OffScreenPass) free(free_images bool) {
	p.pass.free()

	if free_images {
		p.color_tex.free()
		p.depth_tex.free()
	}
}

//#region Resolution Policies for blitting the render target

pub fn (p &OffScreenPass) get_pixel_perfect_config() DrawConfig {
	w, h := window.drawable_size()

	mut scale := 1
	aspect_ratio := f32(w) / f32(h)
	if f32(p.color_tex.width) / f32(p.color_tex.height) > aspect_ratio {
		scale = w / p.color_tex.width
	} else {
		scale = h / p.color_tex.height
	}

	if scale == 0 {
		scale = 1
	}

	x := (w - (p.color_tex.width * scale)) / 2
	y := (h - (p.color_tex.height * scale)) / 2

	return {x:x y:y sx:scale sy:scale}
}

pub fn (p &OffScreenPass) get_pixel_perfect_no_border_config() DrawConfig {
	w, h := window.drawable_size()

	// we are going to do some cropping so we need to use floats for the scale then round up
	mut scale := 1
	aspect_ratio := f32(w) / f32(h)
	if f32(p.color_tex.width) / f32(p.color_tex.height) < aspect_ratio {
		scale_f := f32(w) / p.color_tex.width
		scale = math.iceil(scale_f)
	} else {
		scale_f := f32(h) / p.color_tex.height
		scale = math.iceil(scale_f)
	}

	if scale == 0 {
		scale = 1
	}

	x := (w - (p.color_tex.width * scale)) / 2
	y := (h - (p.color_tex.height * scale)) / 2

	return {x:x y:y sx:scale sy:scale}
}

//#endregion