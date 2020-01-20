module graphics
import via.libs.stb.image
import via.libs.sokol.gfx

pub struct Texture {
pub mut:
	img sg_image
pub:
	width int
	height int
	channels image.Channels
}

pub fn (t Texture) str() string {
	return 'w: $t.width, h: $t.height, id: $t.img.id, channels: $t.channels'
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
	}
	img_desc.content.subimage[0][0] = sg_subimage_content{
		ptr: img.data
		size: img.channels * img.width * img.height
    }

	tex := Texture{
		img: sg_make_image(&img_desc)
		width: img.width
		height: img.height
		channels: img.channels
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
	}
	img_desc.content.subimage[0][0] = sg_subimage_content{
		ptr: pixels.data
		size: sizeof(u32) * pixels.len
    }

	tex := Texture{
		img: sg_make_image(&img_desc)
		width: img_desc.width
		height: img_desc.height
		channels: .rgb_alpha
	}
    return tex
}