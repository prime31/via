module via
import filepath
import via.math
import via.fonts
import via.debug
import via.window
import via.graphics
import via.libs.physfs
import via.libs.sokol.gfx
import via.libs.sokol.sdl_metal_util

struct Graphics {
pub mut:
	viewport math.Rect
mut:
	min_filter gfx.Filter
	mag_filter gfx.Filter
	pass_action C.sg_pass_action
	def_pip graphics.Pipeline
	def_text_pip graphics.Pipeline
	pass_proj_mat math.Mat32
}

pub struct PassActionConfig {
pub:
	color math.Color = math.Color{}
	color_action gfx.Action = gfx.Action.clear
	stencil_action gfx.Action = .clear
	stencil_val byte = byte(0)
}
fn (cfg &PassActionConfig) apply(pa mut C.sg_pass_action) {
	pa.colors[0].action = cfg.color_action
	pa.colors[0].val[0] = cfg.color.r_f()
	pa.colors[0].val[1] = cfg.color.g_f()
	pa.colors[0].val[2] = cfg.color.b_f()
	pa.colors[0].val[3] = cfg.color.a_f()

	pa.stencil.action = cfg.stencil_action
	pa.stencil.val = cfg.stencil_val
}

pub struct PassConfig {
pub:
	pipeline &graphics.Pipeline = &graphics.Pipeline(0)
	trans_mat &math.Mat32 = &math.Mat32(0)
	blit_pass bool = false
}

fn graphics(config &ViaConfig) &Graphics {
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
		mtl_device: sdl_metal_util.get_metal_device()
		mtl_renderpass_descriptor_cb: C.mu_get_render_pass_descriptor
		mtl_drawable_cb: C.mu_get_drawable
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

pub fn (g &Graphics) get_default_pipeline() &graphics.Pipeline {
	return &g.def_pip
}

pub fn (g &Graphics) get_default_text_pipeline() &graphics.Pipeline {
	return &g.def_text_pip
}

pub fn (g mut Graphics) set_default_filter(min, mag gfx.Filter) {
	g.min_filter = min
	g.mag_filter = mag
}

//#region create graphics resources

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
	return graphics.textureatlas(tex, buf)
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

pub fn (g &Graphics) new_offscreen_pass(width, height int) graphics.OffScreenPass {
	return graphics.offscreenpass(width, height, g.min_filter, g.mag_filter)
}

//#endregion

//#region rendering

pub fn (g mut Graphics) begin_offscreen_pass(pass &graphics.OffScreenPass, pass_action_cfg PassActionConfig, config PassConfig) {
	pass_action_cfg.apply(mut g.pass_action)
	sg_begin_pass(pass.pass, &g.pass_action)
	g.viewport.set(0, 0, pass.color_tex.w, pass.color_tex.h)

	mut pip := if config.pipeline == &graphics.Pipeline(0) {
		g.get_default_pipeline()
	} else {
		println('offscreen pass: use custom pip')
		config.pipeline
	}

	// projection matrix with flipped y for OpenGL madness
	mut proj_mat := math.mat32_ortho_off_center(pass.color_tex.w, -pass.color_tex.h)
	if &config.trans_mat != &math.Mat32(0) {
		// TODO: shouldnt this be translation * projection?!?!
		proj_mat = proj_mat * *config.trans_mat
		w, h := window.drawable_size()
	}
	debug.set_proj_mat(proj_mat)

	// save the transform-projection matrix in case a new pipeline is set later
	g.pass_proj_mat = proj_mat
	g.set_pipeline(mut pip)
}

// TODO: might need a separate version for offscreen-to-backbuffer to deal with post processors and such
pub fn (g mut Graphics) begin_default_pass(pass_action_cfg PassActionConfig, config PassConfig) {
	pass_action_cfg.apply(mut g.pass_action)
	w, h := window.drawable_size()
	sg_begin_default_pass(&g.pass_action, w, h)
	g.viewport.set(0, 0, w, h)

	mut pip := if config.pipeline == &graphics.Pipeline(0) {
		g.get_default_pipeline()
	} else {
		println('def pass: use custom pip')
		config.pipeline
	}

	// blitting offscreen textures does not need an ortho off-center matrix so we set the rect to 0,0,w,h
	mut proj_mat := if config.blit_pass {
		math.mat32_ortho(w, h)
	} else {
		math.mat32_ortho_off_center(w, h)
	}

	// non-blit passes could have a translation matrix
	if !config.blit_pass && config.trans_mat != &math.Mat32(0) {
		// TODO: shouldnt this be translation * projection?!?!
		proj_mat = proj_mat * *config.trans_mat
	}

	// save the transform-projection matrix in case a new pipeline is set later
	g.pass_proj_mat = proj_mat
	g.set_pipeline(mut pip)
	debug.set_proj_mat(proj_mat)
}

pub fn (g mut Graphics) end_pass() {
	debug.draw()
	sg_end_pass()
}

pub fn (g &Graphics) set_pipeline(pipeline mut graphics.Pipeline) {
	sg_apply_pipeline(pipeline.pip)
	pipeline.set_uniform_raw(.vs, 0, &g.pass_proj_mat)
	pipeline.apply_uniforms()
}

pub fn (g &Graphics) set_default_pipeline() {
	g.set_pipeline(mut g.def_pip)
}

//#endregion