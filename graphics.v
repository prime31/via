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