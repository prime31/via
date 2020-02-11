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
	def_pass &DefaultOffScreenPass
	pass_proj_mat math.Mat32
	blitted_to_screen bool
}

pub const (
	g = &Graphics{
		tri_batch: 0
		quad_batch: 0
		min_filter: .nearest
 		mag_filter: .nearest
		def_pass: 0
	}
)

//#region setup and config

pub fn free() {
	g.quad_batch.free()
	g.tri_batch.free()
	g.def_pip.free()
	g.def_pass.free()
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
	gg.def_pass = defaultoffscreenpass(config.design_width, config.design_height, config.resolution_policy)
}

pub fn get_default_pipeline() &Pipeline {
	gg := g
	return &gg.def_pip
}

pub fn get_default_text_pipeline() &Pipeline {
	println('---- beware: text_pipelines are no longer supported so a new one is returned every call')
	text_pip := pipeline_new_default_text()
	return &text_pip
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

pub fn new_offscreenpass(width, height int) OffScreenPass {
	return offscreenpass(width, height, g.min_filter, g.mag_filter)
}

pub fn new_effectstack() &EffectStack {
	return effectstack()
}

//#endregion

//#region NEW API render passes

// combine both params into a single one
pub fn begin_pass(config PassConfig) {
	mut gg := g
	config.apply(mut gg.pass_action)

	mut proj_mat := math.Mat32{}

	// if we already blitted to the screen we have to use a default pass
	if gg.blitted_to_screen {
		w, h := window.drawable_size()
		sg_begin_default_pass(&gg.pass_action, w, h)
		proj_mat = math.mat32_ortho(w, h)
	} else {
		pass := if config.pass == 0 { &gg.def_pass.offscreen_pass } else { config.pass }
		C.sg_begin_pass(pass.pass, &gg.pass_action)

		// projection matrix with flipped y for OpenGL madness when rendering offscreen
		proj_mat = math.mat32_ortho_inverted(pass.color_tex.w, -pass.color_tex.h)
	}

	mut pip := if config.pipeline == 0 { get_default_pipeline() } else { config.pipeline }

	if config.trans_mat != 0 {
		// TODO: shouldnt this be translation * projection?!?!
		proj_mat = proj_mat * *config.trans_mat
	}

	// save the transform-projection matrix in case a new pipeline is set later
	gg.pass_proj_mat = proj_mat
	set_pipeline(mut pip)
	debug.set_proj_mat(proj_mat)
}

pub fn end_pass() {
	flush()
	// TODO: can debug drawing be setup to properly render last and work across all passes?
	debug.draw()
	sg_end_pass()
}

pub fn postprocess(pp &EffectStack) {
	mut gg := g
	gg.pass_proj_mat = math.mat32_ortho_inverted(gg.def_pass.offscreen_pass.color_tex.w, -gg.def_pass.offscreen_pass.color_tex.h)
	pp.process(g.def_pass.offscreen_pass)
}

pub fn blit_to_screen(letterbox_color math.Color) {
	mut gg := g
	gg.blitted_to_screen = true

	begin_pass({color:letterbox_color})
	scaler := g.def_pass.scaler
	gg.quad_batch.draw(g.def_pass.offscreen_pass.color_tex, {x:scaler.x y:scaler.y sx:scaler.scale sy:scaler.scale})
	end_pass()
}

//#endregion

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

// flushes the batches
pub fn flush() {
	mut gg := g
	gg.quad_batch.flush()
	gg.tri_batch.flush()
}

// called by Via once at the end of each frame. Ends the batches and commits rendering to the GPU.
pub fn commit() {
	mut gg := g
	gg.quad_batch.end()
	gg.tri_batch.end()
	gg.blitted_to_screen = false
	C.sg_commit()
}

// TODO: temporarily just return the batches until their api solidifies
[inline]
pub fn spritebatch() &QuadBatch { return g.quad_batch }

[inline]
pub fn tribatch() &TriangleBatch { return g.tri_batch }

//#endregion