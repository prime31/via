module tilemap
import via.math

pub struct Map {
pub:
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
		for i in 0..m.tilesets.len { m.tilesets[i].free() }
		for i in 0..m.tile_layers.len { m.tile_layers[i].free() }
		for i in 0..m.object_layers.len { m.object_layers[i].free() }
		for i in 0..m.group_layers.len { m.group_layers[i].free() }

		m.tilesets.free()
		m.tile_layers.free()
		m.object_layers.free()
		m.group_layers.free()
	}
}

pub fn (m &Map) world_width() int {
	return m.width * m.tile_size
}

pub fn (m &Map) world_height() int {
	return m.height * m.tile_size
}

pub fn (m &Map) tilelayer_with_name(name string) &TileLayer {
	for i in 0..m.tile_layers.len {
		if m.tile_layers[i].name == name {
			return &m.tile_layers[i]
		}
	}
	return &TileLayer(0)
}

pub fn (m &Map) objectlayer_with_name(name string) &ObjectLayer {
	for i in 0..m.object_layers.len {
		if m.object_layers[i].name == name {
			return &m.object_layers[i]
		}
	}
	return &ObjectLayer(0)
}

pub fn (m &Map) world_to_tilex(x f32) int {
	tile_x := math.ifloor(x / m.tile_size)
	return math.iclamp(tile_x, 0, m.width - 1)
}

pub fn (m &Map) world_to_tiley(y f32) int {
	tile_y := math.ifloor(y / m.tile_size)
	return math.iclamp(tile_y, 0, m.height - 1)
}

pub fn (m &Map) tile_to_world(x, y int) math.Vec2 {
	return math.Vec2{m.tile_size * x, m.tile_size * y}
}

pub fn (m &Map) tile_to_worldx(x int) int {
	return m.tile_size * x
}

pub fn (m &Map) tile_to_worldy(y int) int {
	return m.tile_size * y
}

pub fn (m &Map) has_tileset_tile(id int) bool {
	return m.tilesets[0].has_tileset_tile(id)
}

pub fn (m &Map) tileset_tile(id int) &TilesetTile {
	return m.tilesets[0].tileset_tile(id)
}
