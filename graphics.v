module via
import via.graphics
import via.libs.sokol.gfx

struct Graphics {
	fs &FileSystem
mut:
	min_filter gfx.Filter
	mag_filter gfx.Filter
}

fn create_graphics(config &ViaConfig, filesystem &FileSystem) &Graphics {
	return &Graphics{
		fs: filesystem
		min_filter: .nearest
 		mag_filter: .nearest
	}
}

fn (g &Graphics) free() {
	unsafe { free(g) }
}

pub fn (g mut Graphics) set_default_filter(min, mag gfx.Filter) {
	g.min_filter = min
	g.mag_filter = mag
}

pub fn (g &Graphics) new_texture(src string) graphics.Texture {
	buf := g.fs.read_bytes(src)
	tex := graphics.texture_load(buf, g.min_filter, g.mag_filter)
	unsafe { buf.free() }
	return tex
}

pub fn (g &Graphics) new_shader(vert, frag string, shader_desc sg_shader_desc) C.sg_shader {
	mut vert_needs_free := false
	vert_src := if vert.len > 0 && vert.ends_with('.vert') {
		g.fs.read_text(vert)
	} else {
		vert
	}

	mut frag_needs_free := false
	frag_src := if frag.len > 0 && vert.ends_with('.frag') {
		g.fs.read_text(frag)
	} else {
		frag
	}

	shader := graphics.shader_make(vert_src, frag_src, mut shader_desc)

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

pub fn (gg &Graphics) new_clear_pass(r, g, b, a f32) sg_pass_action {
	return gfx.create_clear_pass(r, g, b, a)
}

pub fn (g &Graphics) new_spritebatch(tex graphics.Texture, max_sprites int) &graphics.SpriteBatch {
	return graphics.spritebatch_new(tex, max_sprites)
}