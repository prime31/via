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

pub fn (gr &Graphics) make_clear_pass(r, g, b, a f32) graphics.PassAction {
	return gr.make_pass_action({color:math.color_from_floats(r, g, b, a)})
}

pub fn (g &Graphics) make_pass_action(config graphics.PassActionConfig) graphics.PassAction {
	return graphics.passaction(config)
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

pub fn (g &Graphics) new_offscreen_pass(width, height int, clear_color math.Color) graphics.OffScreenPass {
	pass := g.make_pass_action({color:clear_color})
	return graphics.offscreenpass(width, height, g.min_filter, g.mag_filter, pass)
}

//#endregion

//#region rendering

pub fn (g &Graphics) begin_offscreen_pass(pass &graphics.OffScreenPass, config PassConfig) {
	// TODO: begin all batches
	// TODO: set the projection matrix for the pipeline based on the render texture size flipped
	sg_begin_pass(pass.pass, &pass.pass_action)

	mut pip := if config.pipeline == &graphics.Pipeline(0) {
		g.get_default_pipeline()
	} else {
		println('def pass: use custom pip')
		config.pipeline
	}

	sg_apply_pipeline(pip.pip)

	proj_mat := math.mat32_ortho_off_center(pass.color_tex.width, -pass.color_tex.height)
	pip.set_uniform_raw(.vs, 0, &proj_mat)
}

// TODO: might need a separate version for offscreen-to-backbuffer blit that sets mat32_ortho
pub fn (g &Graphics) begin_default_pass(pass_action &graphics.PassAction, config PassConfig) {
	// TODO: begin all batches
	w, h := vv.win.get_drawable_size()
	sg_begin_default_pass(&pass_action.pass, w, h)

	mut pip := if config.pipeline == &graphics.Pipeline(0) {
		g.get_default_pipeline()
	} else {
		println('def pass: use custom pip')
		config.pipeline
	}

	sg_apply_pipeline(pip.pip)

	// blitting offscreen textures does not need an ortho off-center matrix so we set the rect to 0,0,w,h
	proj_mat := if config.blit_pass {
		math.mat32_ortho(w, h)
	} else {
		math.mat32_ortho_off_center(w, h)
	}
	pip.set_uniform_raw(.vs, 0, &proj_mat)
}

pub fn (g &Graphics) end_pass() {
	// TODO: end all batches
	sg_end_pass()
}

//#endregion