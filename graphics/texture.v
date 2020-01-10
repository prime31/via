module graphics
import via.libs.stb.image
import via.libs.sokol.gfx

pub struct Texture {
pub:
	id sg_image
	width int
	height int
	channels image.Channels
}

pub fn (t Texture) str() string {
	return 'w: $t.width, h: $t.height, id: $t.id.id, channels: $t.channels'
}

[unsafe_fn]
pub fn (t Texture) free() {
	sg_destroy_image(t.id)
}


pub fn texture_load(bytes []byte) Texture {
	img := image.load_from_memory(bytes.data, bytes.len) or { panic(err) }

	mut img_desc := sg_image_desc{
		width: img.width
		height: img.height
		wrap_u: .clamp_to_edge
		wrap_v: .clamp_to_edge
	}
	img_desc.content.subimage[0][0] = sg_subimage_content{
		ptr: img.data
		size: img.channels * img.width * img.height
    }

	tex := Texture{
		id: sg_make_image(&img_desc)
		width: img.width
		height: img.height
		channels: img.channels
	}

	img.free()
	return tex
}