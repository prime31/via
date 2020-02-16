module tilemap

const (
	flipped_h = 0x08000000
	flipped_v = 0x04000000
	flipped_d = 0x02000000
)

// this is a transient struct only used for rendering and not stored at all. This could potentially
// just be put in maprenderer.
struct Tile {
	id int
mut:
	rot f32
	sx f32 = 1.0
	sy f32 = 1.0
	ox f32
	oy f32
}

fn tile(id, tile_size int) Tile {
	mut t := Tile{
		id: id & ~(flipped_h | flipped_v | flipped_d)
	}

	mut flip_h := false
	mut flip_v := false

	// deal with flipping/rotating if necessary
	if id > flipped_d {
		// set the origin based on the tile_size if we are rotated
		t.ox = tile_size / 2
		t.oy = tile_size / 2

		if (id & flipped_h) != 0 {
			t.sx = -1.0
			flip_h = true
		}

		if (id & flipped_v) != 0 {
			t.sy = -1.0
			flip_v = true
		}

		if (id & flipped_d) != 0 {
			if flip_h && flip_v {
				t.rot = 90.0
			} else if flip_h {
				t.rot = -90.0
			} else if flip_v {
				t.rot = 90.0
			} else {
				t.rot = -90.0
			}
		}
	}

	return t
}
