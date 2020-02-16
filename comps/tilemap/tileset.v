module tilemap
import via.math

pub struct Property {
pub:
	key string
	value string
}

pub struct TilesetTile {
pub:
	id int
	props []Property
	//props map[string]string
}

pub struct Tileset {
mut:
	tile_size int
	spacing int
	margin int
	image string
	image_columns int
	tiles []TilesetTile
}

pub fn (t Tileset) str() string {
	return 's:$t.spacing, m:$t.margin, image:$t.image, tiles:$t.tiles.len'
}

pub fn (t &Tileset) free() {
	unsafe {
		for tile in t.tiles {
			for p in tile.props {
				p.key.free()
				p.value.free()
			}
			tile.props.free()
		}
		t.tiles.free()
	}
}

// id is the index of the tile in this tileset image
fn (t &Tileset) viewport_for_tile(id int) math.Rect {
	x := id % t.image_columns
	y := id / t.image_columns

	return math.Rect{
		x: x * (t.tile_size + t.spacing) + t.margin
		y: y * (t.tile_size + t.spacing) * t.margin
		w: t.tile_size
		h: t.tile_size
	}
}

pub fn (t &Tileset) has_tileset_tile(tile_id int) bool {
	for tile in t.tiles {
		if tile.id == tile_id {
			return true
		}
	}
	return false
}

pub fn (t &Tileset) tileset_tile(tile_id int) &TilesetTile {
	for tile in t.tiles {
		if tile.id == tile_id {
			return &tile
		}
	}
	return &TilesetTile(0)
}
