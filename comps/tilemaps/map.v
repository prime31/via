module tilemaps

pub struct Map {
    width int
    height int
	tile_size int
pub mut:
	tilesets []Tileset // TODO: support multiple Tilesets
	tile_layers []TileLayer
	object_layers []ObjectLayer
	group_layers []GroupLayer
	// image_layers []ImageLayer
}

pub fn (m Map) str() string {
	return '[Map] w:$m.width, h:$m.height, ts:$m.tile_size\ntilesets:$m.tilesets\ntile_layers:$m.tile_layers\nobject_layers:$m.object_layers\ngroup_layers:$m.group_layers'
}

pub fn (m &Map) free() {
	unsafe {
		for ts in m.tilesets { ts.free() }
		for tl in m.tile_layers { tl.free() }
		for ol in m.object_layers { ol.free() }
		for gl in m.group_layers { gl.free() }

		m.tilesets.free()
		m.tile_layers.free()
		m.object_layers.free()
		m.group_layers.free()
	}
}

// after reconstituting from disk this should be called to let the data structures set themselves up
pub fn (m &Map) prepare() {
	for ts in m.tilesets {
		ts.prepare()
	}
}

pub fn (m &Map) world_width() int {
	return m.width * m.tile_size
}

pub fn (m &Map) world_height() int {
	return m.height * m.tile_size
}

//GetLayer(string name)
//WorldToTilePosition(Vector2 pos, bool clampToTilemapBounds = true)
//WorldToTilePositionX(float x, bool clampToTilemapBounds = true)
//WorldToTilePositionY(float y, bool clampToTilemapBounds = true)
//TileToWorldPosition(Vector2 pos)
//TileToWorldPositionX(int x)
//TileToWorldPositionY(int y)