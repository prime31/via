module graphics
import via.libs.stb.image
import via.libs.sokol.gfx

pub struct Texture {
pub mut:
	img sg_image
pub:
	w int
	h int
}

pub fn (t Texture) str() string {
	return 'w: $t.w, h: $t.h, id: $t.img.id'
}

pub fn (t Texture) eq(other Texture) bool {
	return t.img.id == other.img.id
}

pub fn (t Texture) ne(other Texture) bool {
	return !t.eq(other)
}

pub fn (t Texture) free() {
	t.img.free()
}


pub fn texture(bytes []byte, min_filter, mag_filter gfx.Filter) Texture {
	img := image.load_from_memory(bytes.data, bytes.len)
	defer { img.free() }

	mut img_desc := sg_image_desc{
		width: img.width
		height: img.height
		num_mipmaps: 0
		min_filter: min_filter
		mag_filter: mag_filter
		wrap_u: .clamp_to_edge
		wrap_v: .clamp_to_edge
		label: &byte(0)
		d3d11_texture: 0
	}
	img_desc.content.subimage[0][0] = sg_subimage_content{
		ptr: img.data
		size: img.channels * img.width * img.height
    }

	tex := Texture{
		img: sg_make_image(&img_desc)
		w: img.width
		h: img.height
	}
	return tex
}

pub fn rendertexture(width, height int, min_filter, mag_filter gfx.Filter, depth_stencil bool) Texture {
	mut img_desc := sg_image_desc{
		render_target: true
		width: width
		height: height
		num_mipmaps: 0
		min_filter: min_filter
		mag_filter: mag_filter
		wrap_u: .clamp_to_edge
		wrap_v: .clamp_to_edge
		label: &byte(0)
		d3d11_texture: 0
	}

	if depth_stencil {
		img_desc.pixel_format = .depth_stencil
	}

	tex := Texture{
		img: sg_make_image(&img_desc)
		w: width
		h: height
	}
	return tex
}

fn new_checker_texture() Texture {
    pixels := [
        u32(0xFFFFFFFF), 0x00000000, 0xFFFFFFFF, 0x00000000,
        0x00000000, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFF,
        0xFFFFFFFF, 0x00000000, 0xFFFFFFFF, 0x00000000,
        0x00000000, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFF,
	]!

	mut img_desc := sg_image_desc{
		width: 4
		height: 4
		pixel_format: .rgba8
		min_filter: .nearest
		mag_filter: .nearest
		wrap_u: .clamp_to_edge
		wrap_v: .clamp_to_edge
		label: &byte(0)
		d3d11_texture: 0
	}
	img_desc.content.subimage[0][0] = sg_subimage_content{
		ptr: pixels.data
		size: sizeof(u32) * pixels.len
    }

	tex := Texture{
		img: sg_make_image(&img_desc)
		w: img_desc.width
		h: img_desc.height
	}
    return tex
}