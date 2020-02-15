module tilemap

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

pub fn (t &Tileset) has_tileset_tile_for_tile_id(id int) bool {
	for tile in t.tiles {
		if tile.id == id {
			return true
		}
	}
	return false
}

pub fn (t &Tileset) tileset_tile_for_tile_id(id int) &TilesetTile {
	for tile in t.tiles {
		if tile.id == id {
			return &tile
		}
	}
	return &TilesetTile(0)
}
