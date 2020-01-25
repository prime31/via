module via
import filepath
import via.math
import via.fonts
import via.graphics
import via.libs.physfs
import via.libs.sokol.gfx

struct Graphics {
mut:
	min_filter gfx.Filter
	mag_filter gfx.Filter
	def_pip graphics.Pipeline
	def_text_pip graphics.Pipeline
}

fn new_graphics(config &ViaConfig) &Graphics {
	return &Graphics{
		min_filter: .nearest
 		mag_filter: .nearest
	}
}

fn (g &Graphics) free() {
	g.def_pip.free()
	g.def_text_pip.free()
	unsafe { free(g) }
}

fn (g &Graphics) setup() {
	desc := sg_desc{
		mtl_device: 0
		mtl_renderpass_descriptor_cb: 0
		mtl_drawable_cb: 0
		d3d11_device: 0
		d3d11_device_context: 0
		d3d11_render_target_view_cb: 0
		d3d11_depth_stencil_view_cb: 0
	}
	sg_setup(&desc)
}

fn (g mut Graphics) init_defaults() {
	g.def_pip = graphics.pipeline_new_default()
	g.def_text_pip = graphics.pipeline_new_default_text()
}

pub fn (g &Graphics) get_default_pipeline() graphics.Pipeline {
	return g.def_pip
}

pub fn (g &Graphics) get_default_text_pipeline() graphics.Pipeline {
	return g.def_text_pip
}

pub fn (g mut Graphics) set_default_filter(min, mag gfx.Filter) {
	g.min_filter = min
	g.mag_filter = mag
}

pub fn (g &Graphics) new_texture(src string) graphics.Texture {
	buf := physfs.read_bytes(src)
	tex := graphics.texture(buf, g.min_filter, g.mag_filter)
	unsafe { buf.free() }
	return tex
}

pub fn (g &Graphics) new_texture_atlas(src string) graphics.TextureAtlas {
	tex_src := src.replace(filepath.ext(src), '.png')
	tex := g.new_texture(tex_src)

	buf := physfs.read_bytes(src)
	return graphics.texture_atlas(tex, buf)
}

pub fn (g &Graphics) new_shader(src graphics.ShaderSourceConfig, shader_desc &sg_shader_desc) C.sg_shader {
	mut vert_needs_free := false
	vert_src := if src.vert.len > 0 && src.vert.ends_with('.vert') {
		vert_needs_free = true
		physfs.read_text(src.vert)
	} else {
		src.vert
	}

	mut frag_needs_free := false
	frag_src := if src.frag.len > 0 && src.frag.ends_with('.frag') {
		frag_needs_free = true
		physfs.read_text(src.frag)
	} else {
		src.frag
	}

	shader := graphics.shader_make({vert: vert_src frag: frag_src}, mut shader_desc)

	if vert_needs_free {
		unsafe{ vert_src.free() }
	}
	if frag_needs_free {
		unsafe{ frag_src.free() }
	}

	return shader
}

pub fn (g &Graphics) new_pipeline(pipeline_desc &sg_pipeline_desc) sg_pipeline {
	return sg_make_pipeline(pipeline_desc)
}

pub fn (g &Graphics) new_atlasbatch(tex graphics.Texture, max_sprites int) &graphics.AtlasBatch {
	return graphics.atlasbatch(tex, max_sprites)
}

pub fn (g &Graphics) new_fontstash(width, height int) &fonts.FontStash {
	return fonts.fontstash(width, height, g.min_filter, g.mag_filter)
}

pub fn (gg &Graphics) make_clear_pass(r, g, b, a f32) sg_pass_action {
	return gfx.make_clear_pass(r, g, b, a)
}

pub fn (g &Graphics) new_offscreen_pass(width, height int, clear_color math.Color) graphics.OffScreenPass {
	return graphics.offscreenpass(width, height, g.min_filter, g.mag_filter, clear_color)
}