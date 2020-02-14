module tilemap

pub struct Map {
    width int
    height int
	tile_size int
	tileset []Tileset // TODO: support multiple Tilesets
	tile_layers []TileLayer
	object_layers []ObjectLayer
}

pub fn (m &Map) free() {
	unsafe {
		m.tileset.free()
		m.tile_layers.free()
		m.object_layers.free()
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