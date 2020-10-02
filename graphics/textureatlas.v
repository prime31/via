module graphics
import via.math
import via.utils

pub struct TextureAtlas {
pub:
	tex Texture
pub mut:
	quad_map map[string]math.Quad
}

enum AtlasParserState {
	quad_name
	quad_viewport
	quad_origin
}

pub fn textureatlas(tex Texture, bytes []byte) TextureAtlas {
	mut atlas := TextureAtlas{
		tex: tex
	}

	mut state := AtlasParserState.quad_name
	mut quad_name := string{}
	mut vp := [f32(0), 0, 0, 0]!!
	mut vp_i := 0

	mut buf := utils.new_parser_buffer(150)
	defer { unsafe { buf.free() } }
	for i in 0..bytes.len {
		b := bytes[i]

		if state == .quad_viewport {
			// comma delimited with a tab to start the line
			if b == `,` || b == `\n` {
				val := buf.str()
				vp[vp_i] = val.f32()
				buf.reset()
				vp_i++

				if vp_i == 4 {
					atlas.quad_map[quad_name] = math.quad(vp[0], vp[1], vp[2], vp[3], tex.w, tex.h)
					vp_i = 0
					state = .quad_origin
				}

				continue
			} else if b == `\t` {
				continue
			}
		}

		// newline means the end of the parsed data
		if b == `\n` {
			match state {
				.quad_name {
					// two newlines in a row means we are done with sprites and onto animations
					if buf.len == 0 {
						break
					}
					quad_name = buf.str().clone()
					buf.reset()
					state = .quad_viewport
					continue
				}
				.quad_origin {
					buf.reset()
					state = .quad_name
					continue
				}
				else {  }
			}
		}

		buf.write_b(b)
	}

	return atlas
}

pub fn (a &TextureAtlas) get_names() []string {
	return a.quad_map.keys()
}

pub fn (a &TextureAtlas) get_quad(name string) math.Quad {
	return a.quad_map[name]
}

pub fn (a &TextureAtlas) free() {
	unsafe { a.quad_map.free() }
	a.tex.free()
}