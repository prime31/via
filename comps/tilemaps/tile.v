module tilemaps
import via.math

const (
	flipped_h = 0x08000000
	flipped_v = 0x04000000
	flipped_d = 0x02000000
)

[flag]
pub enum Flipped {
	no
	horizontal
	vertical
	diagonally
}


pub struct Tile {
	id int
mut:
	flipped Flipped
	rot f32
	sx f32 = 1.0
	sy f32 = 1.0
	ox f32
	oy f32
}

fn tile(id, tile_size int) Tile {
	pre_id := id
	mut t := Tile{
		id: id & ~(flipped_h | flipped_v | flipped_d)
	}

	// deal with flipping/rotating if necessary
	if id > flipped_d {
		// set the origin based on the tile_size if we are rotated
		t.ox = tile_size / 2
		t.oy = tile_size / 2

		if (id & flipped_h) != 0 {
			t.sx = -1.0
			t.flipped.set(.horizontal)
		}

		if (id & flipped_v) != 0 {
			t.sy = -1.0
			t.flipped.set(.vertical)
		}

		if (id & flipped_d) != 0 {
			t.flipped.set(.diagonally)

			if t.flipped.has(.horizontal) && t.flipped.has(.vertical) {
				t.rot = 90.0
			} else if t.flipped.has(.horizontal) {
				t.rot = -90.0
			} else if t.flipped.has(.vertical) {
				t.rot = 90.0
			} else {
				t.rot = -90.0
			}
		}
	}

	return t
}

fn (t mut Tile) viewport(tex_w, tex_h, tile_size, spacing, margin int) math.Rect {
	// determine number of columns in the image
	mut columns := 0
	mut accum_w := margin * 2
	for {
		columns++
		accum_w += tile_size + 2 * spacing
		if accum_w >= tex_w {
			break
		}
	}

	x := t.id % columns
	y := t.id / columns

	return math.Rect{
		x: x * tile_size
		y: y * tile_size
		w: tile_size
		h: tile_size
	}
}

/* cache the Viewports for each tile
var id = firstGid;
for (var y = tileset.Margin; y < tileset.Image.Height - tileset.Margin; y += tileset.TileHeight + tileset.Spacing)
{
	var column = 0;
	for (var x = tileset.Margin; x < tileset.Image.Width - tileset.Margin; x += tileset.TileWidth + tileset.Spacing)
	{
		tileset.TileRegions.Add(id++, new RectangleF(x, y, tileset.TileWidth, tileset.TileHeight));

		if (++column >= tileset.Columns)
			break;
	}
}*/