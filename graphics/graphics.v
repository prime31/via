module graphics
import filepath
import via.math
import via.fonts
import via.debug
import via.window
import via.libs.physfs
import via.libs.sokol.gfx
import via.libs.sokol.sdl_metal_util

struct Graphics {
pub mut:
	viewport math.Rect
mut:
	quad_batch &QuadBatch
	tri_batch &TriangleBatch
	min_filter gfx.Filter
	mag_filter gfx.Filter
	pass_action C.sg_pass_action
	def_pip Pipeline
	def_text_pip Pipeline
	pass_proj_mat math.Mat32
	in_default_pass bool
}

pub const (
	g = &Graphics{
		tri_batch: 0
		quad_batch: 0
		min_filter: .nearest
 		mag_filter: .nearest
	}
)

pub struct PassActionConfig {
pub:
	color math.Color = math.Color{}
	color_action gfx.Action = gfx.Action.clear
	stencil_action gfx.Action = .clear
	stencil byte = byte(0)
}

fn (cfg &PassActionConfig) apply(pa mut C.sg_pass_action) {
	pa.colors[0].action = cfg.color_action
	pa.colors[0].val[0] = cfg.color.r_f()
	pa.colors[0].val[1] = cfg.color.g_f()
	pa.colors[0].val[2] = cfg.color.b_f()
	pa.colors[0].val[3] = cfg.color.a_f()

	pa.stencil.action = cfg.stencil_action
	pa.stencil.val = cfg.stencil
}

pub struct PassConfig {
pub:
	pipeline &Pipeline
	trans_mat &math.Mat32 = &math.Mat32(0)
	blit_pass bool = false
}

//#region setup and config

pub fn free() {
	g.quad_batch.free()
	g.tri_batch.free()
	g.def_pip.free()
	g.def_text_pip.free()
	unsafe { free(g) }
}

pub fn setup(max_quad_cnt, max_tri_cnt int) {
	mut gg := g

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

	gg.quad_batch = quadbatch(max_quad_cnt)
	gg.tri_batch = trianglebatch(max_tri_cnt)
	gg.def_pip = pipeline_new_default()
	gg.def_text_pip = pipeline_new_default_text()
}

pub fn get_default_pipeline() &Pipeline {
	gg := g
	return &gg.def_pip
}

pub fn get_default_text_pipeline() &Pipeline {
	gg := g
	return &gg.def_text_pip
}

pub fn set_default_filter(min, mag gfx.Filter) {
	mut gg := g
	gg.min_filter = min
	gg.mag_filter = mag
}

//#endregion

//#region create graphics resources

pub fn new_texture(src string) Texture {
	buf := physfs.read_bytes(src)
	tex := texture(buf, g.min_filter, g.mag_filter)
	unsafe { buf.free() }
	return tex
}

pub fn new_texture_atlas(src string) TextureAtlas {
	tex_src := src.replace(filepath.ext(src), '.png')
	tex := new_texture(tex_src)

	buf := physfs.read_bytes(src)
	return textureatlas(tex, buf)
}

pub fn new_shader(src ShaderSourceConfig, shader_desc &sg_shader_desc) C.sg_shader {
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

	shader := shader_make({vert: vert_src frag: frag_src}, mut shader_desc)

	if vert_needs_free {
		unsafe{ vert_src.free() }
	}
	if frag_needs_free {
		unsafe{ frag_src.free() }
	}

	return shader
}

pub fn new_pipeline(pipeline_desc &C.sg_pipeline_desc) C.sg_pipeline {
	return sg_make_pipeline(pipeline_desc)
}

pub fn new_atlasbatch(tex Texture, max_sprites int) &AtlasBatch {
	return atlasbatch(tex, max_sprites)
}

pub fn new_fontbook(width, height int) &fonts.FontBook {
	return fonts.fontbook(width, height, g.min_filter, g.mag_filter)
}

pub fn new_offscreen_pass(width, height int) OffScreenPass {
	return offscreenpass(width, height, g.min_filter, g.mag_filter)
}

//#endregion

//#region rendering

pub fn begin_offscreen_pass(pass &OffScreenPass, pass_action_cfg PassActionConfig, config PassConfig) {
	mut gg := g

	pass_action_cfg.apply(mut gg.pass_action)
	sg_begin_pass(pass.pass, &gg.pass_action)
	gg.viewport.set(0, 0, pass.color_tex.w, pass.color_tex.h)

	mut pip := if config.pipeline == &Pipeline(0) {
		get_default_pipeline()
	} else {
		println('offscreen pass: use custom pip')
		config.pipeline
	}

	// projection matrix with flipped y for OpenGL madness
	mut proj_mat := math.mat32_ortho_off_center(pass.color_tex.w, -pass.color_tex.h)
	if &config.trans_mat != &math.Mat32(0) {
		// TODO: shouldnt this be translation * projection?!?!
		proj_mat = proj_mat * *config.trans_mat
	}
	debug.set_proj_mat(proj_mat)

	// save the transform-projection matrix in case a new pipeline is set later
	gg.pass_proj_mat = proj_mat
	set_pipeline(mut pip)
}

// TODO: might need a separate version for offscreen-to-backbuffer to deal with post processors and such
pub fn begin_default_pass(pass_action_cfg PassActionConfig, config PassConfig) {
	mut gg := g
	gg.in_default_pass = true

	pass_action_cfg.apply(mut gg.pass_action)
	w, h := window.drawable_size()
	sg_begin_default_pass(&gg.pass_action, w, h)
	gg.viewport.set(0, 0, w, h)

	mut pip := if config.pipeline == &Pipeline(0) {
		get_default_pipeline()
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
	gg.pass_proj_mat = proj_mat
	set_pipeline(mut pip)
	debug.set_proj_mat(proj_mat)
}

pub fn end_pass() {
	// if we are in our default pass this is the end of rendering to close out the batches
	if g.in_default_pass {
		mut gg := g
		gg.in_default_pass = false
		gg.quad_batch.end()
		gg.tri_batch.end()
	} else {
		flush()
	}

	debug.draw()
	sg_end_pass()
}

pub fn set_pipeline(pipeline mut Pipeline) {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.flush()

	sg_apply_pipeline(pipeline.pip)
	pipeline.set_uniform_raw(.vs, 0, &gg.pass_proj_mat)
	pipeline.apply_uniforms()
}

pub fn set_default_pipeline() {
	mut gg := g
	set_pipeline(mut gg.def_pip)
}

pub fn flush() {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.flush()
}

//#endregion