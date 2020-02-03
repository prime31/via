module fonts
import via.math
import via.time
import via.libs.fontstash
import via.libs.physfs
import via.libs.sokol.gfx

const (
	// controls texture type. If true, texture is 4x larger but we can use our standard quad pip to render
	// text. If false, the tex is r8 and we need to use graphics.get_default_text_pipeline() to render.
	convert_font_tex_to_rgba = true
)

pub struct FontStash {
pub mut:
	stash &C.FONScontext
	img C.sg_image
	min_filter gfx.Filter
	mag_filter gfx.Filter
	width int
	height int
	last_update u32 = u32(0)
	tex_dirty bool
}

pub fn fontstash(width, height int, min_filter, mag_filter gfx.Filter) &FontStash {
	mut fs := &FontStash{
		stash: &C.FONScontext(0)
	}

	params := C.FONSparams{
		width: width
		height: height
		flags: fontstash.FonsFlags.top_left
		userPtr: fs
		renderCreate: render_create
		renderResize: render_resize
		renderUpdate: render_update
		renderDraw: render_draw
		renderDelete: render_delete
	}

	fs.stash = C.fonsCreateInternal(&params)

	return fs
}

pub fn (fs &FontStash) free() {
	C.fonsDeleteInternal(fs.stash)
}

// callbacks
fn render_create(uptr voidptr, width int, height int) int {
	mut fs := &FontStash(uptr)

    // create or re-create font atlas texture
    if fs.img.id != C.SG_INVALID_ID {
        sg_destroy_image(fs.img)
        fs.img.id = u32(C.SG_INVALID_ID)
    }

    fs.width = width
    fs.height = height

	img_desc := C.sg_image_desc{
		width: width
		height: height
		num_mipmaps: 0
		min_filter: fs.min_filter
		mag_filter: fs.mag_filter
		wrap_u: .clamp_to_edge
		wrap_v: .clamp_to_edge
		usage: .dynamic
		pixel_format: if convert_font_tex_to_rgba { gfx.PixelFormat.rgba8 } else { gfx.PixelFormat.r8 }
		label: 'FontStash'.str
		d3d11_texture: 0
	}

    fs.img = sg_make_image(&img_desc)

	return 1
}

fn render_resize(uptr voidptr, width int, height int) int {
	return render_create(uptr, width, height)
}

fn render_update(uptr voidptr, rect &int, data byteptr) {
	mut font := &FontStash(uptr)
	font.update_texture()
}

fn render_draw(uptr voidptr, verts_ptr &f32, tcoords_ptr &f32, colors_ptr &u32, nverts int) {
	println('---- FontStash.render_draw called ----')
	mut fs := &FontStash(uptr)

	if fs.tex_dirty {
		fs.update_texture()
	}

	// verts := *f32(verts_ptr)
	// tcoords := *f32(tcoords_ptr)
	// colors := *f32(colors_ptr)

	// for i in 0..nverts {
		//sgl_v2f_t2f_c1i(verts[2*i+0], verts[2*i+1], tcoords[2*i+0], tcoords[2*i+1], colors[i]);
		//println('$i: ${verts[i]}')
	// }
}

fn render_delete(uptr voidptr) {
	println('render_delete')
	mut fs := &FontStash(uptr)
	if fs.img.id != C.SG_INVALID_ID {
        sg_destroy_image(fs.img)
	}
	unsafe { free(fs) }
}

pub fn (font mut FontStash) update_texture() {
	if font.tex_dirty && time.frame_count() != font.last_update {
		font.last_update = time.frame_count()

		if convert_font_tex_to_rgba {
			tex_area := font.width * font.height
			unsafe {
				mut data := malloc(tex_area * 4 * sizeof(byte))

				for i in 0..tex_area {
					b := font.stash.texData[i]
					data[i * 4] = 255
					data[i * 4 + 1] = 255
					data[i * 4 + 2] = 255
					data[i * 4 + 3] = b
				}

				mut content := sg_image_content{}
				content.subimage[0][0].ptr = data
				content.subimage[0][0].size = tex_area * 4 * sizeof(byte)
				sg_update_image(font.img, &content)

				free(data)
			}
		} else {
			mut content := sg_image_content{}
			content.subimage[0][0].ptr = font.stash.texData
			content.subimage[0][0].size = font.width * font.height
			sg_update_image(font.img, &content)
		}

		font.tex_dirty = false
	} else {
		font.tex_dirty = true
	}
}

// Add fonts
pub fn (font &FontStash) add_font(src string) int {
	bytes := physfs.read_bytes(src)
	return C.fonsAddFontMem(font.stash, src.str, bytes.data, bytes.len, true)
}

pub fn (font &FontStash) get_font_by_name(name string) int {
	return C.fonsGetFontByName(font.stash, name.str)
}

// State handling
pub fn (font &FontStash) push_state() {
	C.fonsPushState(font.stash)
}

pub fn (font &FontStash) pop_state() {
	C.fonsPopState(font.stash)
}

pub fn (font &FontStash) clear_state() {
	C.fonsClearState(font.stash)
}

// State setting
pub fn (font &FontStash) set_size(size f32) {
	C.fonsSetSize(font.stash, size)
}

pub fn (font &FontStash) set_color(color math.Color) {
	C.fonsSetColor(font.stash, color.value)
}

pub fn (font &FontStash) set_spacing(spacing f32) {
	C.fonsSetSpacing(font.stash, spacing)
}

pub fn (font &FontStash) set_blur(blur f32) {
	C.fonsSetBlur(font.stash, blur)
}

pub fn (font &FontStash) set_align(align fontstash.FonsAlign) {
	C.fonsSetAlign(font.stash, align)
}

pub fn (fs &FontStash) set_font(font int) {
	C.fonsSetFont(fs.stash, font)
}

// drawing
pub fn (font &FontStash) draw_text(x f32, y f32, str string) f32 {
	return C.fonsDrawText(font.stash, x, y, str.str, C.NULL)
}

pub fn (font &FontStash) iter_text(x f32, y f32, str string) {
	iter := C.FONStextIter{}
	C.fonsTextIterInit(font.stash, &iter, x, y, str.str, C.NULL)

	quad := C.FONSquad{}
	mut iter_result := 1
	for iter_result == 1 {
		iter_result = C.fonsTextIterNext(font.stash, &iter, &quad)
		// println('iter $quad')
	}
}