module graphics
import filepath
import via.math
import via.fonts
import via.debug
import via.window
import via.filesystem
import via.libs.sokol.gfx
import via.libs.sokol.sdl_metal_util

struct Graphics {
mut:
	quad_batch &QuadBatch
	tri_batch &TriangleBatch
	min_filter gfx.Filter
	mag_filter gfx.Filter
	pass_action C.sg_pass_action
	def_pip Pipeline
	def_text_pip Pipeline
	def_pass &DefaultOffScreenPass
	fs_quad &FullscreenQuad // TODO: create this on the fly only if post processing is needed
	pass_proj_mat math.Mat32
	in_default_pass bool
}

pub const (
	g = &Graphics{
		tri_batch: 0
		quad_batch: 0
		min_filter: .nearest
 		mag_filter: .nearest
		def_pass: 0
		fs_quad: 0
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
	g.def_pass.free()
	g.fs_quad.free()
	unsafe { free(g) }
}

pub fn setup(config GraphicsConfig) {
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

	set_default_filter(config.min_filter, config.mag_filter)
	gg.quad_batch = quadbatch(config.max_quads)
	gg.tri_batch = trianglebatch(config.max_tris)
	gg.def_pip = pipeline_new_default()
	gg.def_text_pip = pipeline_new_default_text()
	gg.def_pass = defaultoffscreenpass(config.design_width, config.design_height, config.resolution_policy)
	gg.fs_quad = fullscreenquad()
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

pub fn get_resolution_scaler() &ResolutionScaler {
	mut gg := g
	return &gg.def_pass.scaler
}

//#endregion

//#region create graphics resources

pub fn new_texture(src string) Texture {
	buf := filesystem.read_bytes(src)
	tex := texture(buf, g.min_filter, g.mag_filter)
	unsafe { buf.free() }
	return tex
}

pub fn new_texture_atlas(src string) TextureAtlas {
	tex_src := src.replace(filepath.ext(src), '.png')
	tex := new_texture(tex_src)

	buf := filesystem.read_bytes(src)
	return textureatlas(tex, buf)
}

pub fn new_shader(src ShaderSourceConfig, shader_desc &sg_shader_desc) C.sg_shader {
	mut vert_needs_free := false
	vert_src := if src.vert.len > 0 && src.vert.ends_with('.vert') {
		vert_needs_free = true
		filesystem.read_text(src.vert)
	} else {
		src.vert
	}

	mut frag_needs_free := false
	frag_src := if src.frag.len > 0 && src.frag.ends_with('.frag') {
		frag_needs_free = true
		filesystem.read_text(src.frag)
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

	mut pip := if config.pipeline == 0 {
		get_default_pipeline()
	} else {
		println('offscreen pass: use custom pip')
		config.pipeline
	}

	// projection matrix with flipped y for OpenGL madness
	// blitting offscreen textures does not need an ortho off-center matrix so we set the rect to 0,0,w,h
	mut proj_mat := if config.blit_pass {
		math.mat32_ortho_inverted(pass.color_tex.w, -pass.color_tex.h)
	} else {
		math.mat32_ortho_off_center(pass.color_tex.w, -pass.color_tex.h)
	}

	if !config.blit_pass && config.trans_mat != 0 {
		// TODO: shouldnt this be translation * projection?!?!
		proj_mat = proj_mat * *config.trans_mat
	}

	// save the transform-projection matrix in case a new pipeline is set later
	gg.pass_proj_mat = proj_mat
	set_pipeline(mut pip)
	debug.set_proj_mat(proj_mat)
}

pub fn begin_default_offscreen_pass(pass_action_cfg PassActionConfig, config PassConfig) {
	begin_offscreen_pass(g.def_pass.offscreen_pass, pass_action_cfg, config)
}

// TODO: implement and properly name
pub fn postprocess_default_offscreen() {
	mut gg := g

	// we need to have two OffScreenPasses to bounce back and forth for the post processing
	// perhaps DefaultOffScreenPass can manage a second OffScreenPass and create it on the fly when needed?
	// - set pass_proj_mat so all pipelines bound will get the projection matrix
	// - sg_begin_pass() with 2nd OffScreenPass
	// - set_pipeline()
	// - fs_quad.bind_texture() with 1st OffScreenPass rt and somehow let post processor pipelines set other textures
	// - fs_quad.draw()
	// - 	repeat previous 4 steps swapping to the 1st OffScreenPass and then back to the 2nd if there are more post processors
	// - end_pass()
	//
	// - blit_default_offscreen() making sure to use the last written to OffScreenPass

	gg.pass_proj_mat = math.mat32_ortho(gg.def_pass.offscreen_pass.color_tex.w, -gg.def_pass.offscreen_pass.color_tex.h)

	sg_begin_pass(gg.def_pass.offscreen_pass.pass, &gg.pass_action)
	// set_pipeline()
	gg.fs_quad.bind_texture(0, g.def_pass.offscreen_pass.color_tex)
	gg.fs_quad.draw()
	end_pass()
}

// TODO: horrible name
pub fn blit_default_offscreen(letterbox_color math.Color) {
	mut gg := g
	begin_default_pass({color:letterbox_color}, {blit_pass:true})
	scaler := g.def_pass.scaler
	gg.quad_batch.draw(g.def_pass.offscreen_pass.color_tex, {x:scaler.x y:scaler.y sx:scaler.scale sy:scaler.scale})
	end_pass()
}

pub fn begin_default_pass(pass_action_cfg PassActionConfig, config PassConfig) {
	mut gg := g
	gg.in_default_pass = true

	pass_action_cfg.apply(mut gg.pass_action)
	w, h := window.drawable_size()
	sg_begin_default_pass(&gg.pass_action, w, h)

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
	if !config.blit_pass && config.trans_mat != 0 {
		// TODO: shouldnt this be translation * projection?!?!
		proj_mat = proj_mat * *config.trans_mat
	}

	// save the transform-projection matrix in case a new pipeline is set later
	gg.pass_proj_mat = proj_mat
	set_pipeline(mut pip)
	debug.set_proj_mat(proj_mat)
}

pub fn end_pass() {
	// if we are in our default pass this is the end of rendering so close out the batches
	if g.in_default_pass {
		mut gg := g
		gg.in_default_pass = false
		gg.quad_batch.end()
		gg.tri_batch.end()
	} else {
		flush()
	}

	// TODO: can debug drawing be setup to properly render last and work accross all passes?
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

// TODO: temporarily just return the batches until their api solidifies
pub fn spritebatch() &QuadBatch { return g.quad_batch }

pub fn tribatch() &TriangleBatch { return g.tri_batch }

//#endregion