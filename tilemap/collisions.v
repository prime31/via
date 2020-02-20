module tilemap
import via.math

const (
	// the inset on the horizontal plane that the BoxCollider will be shrunk by when moving vertically
	horiz_inset = 2
	// the inset on the vertical plane that the BoxCollider will be shrunk by when moving horizontally
	vert_inset = 6
)

pub fn move(map &Map, rect math.Rect, movement mut math.Vec2) {
	layer := map.tile_layers[0]

	if movement.x != 0 {
		movement.x = movex(map, layer, rect, int(movement.x))
	}
	if movement.y != 0 || movement.x != 0 {
		movement.y = movey(map, layer, rect, int(movement.y))
	}
}

pub fn movex(map &Map, layer &TileLayer, rect math.Rect, movex int) int {
	edge := if movex > 0 { math.Edge.right } else { math.Edge.left }
	mut bounds := rect.half_rect(edge)
	// we contract horizontally for vertical movement and vertically for horizontal movement
	bounds.contract(0, vert_inset)
	// finally expand the side in the direction of movement
	bounds.expand_edge(edge, movex)

	minx := map.world_to_tilex(bounds.x)
	miny := map.world_to_tiley(bounds.y)
	maxx := map.world_to_tilex(bounds.right())
	maxy := map.world_to_tiley(bounds.bottom())

	for x := minx; x <= maxx; x++ {
		for y := miny; y <= maxy; y++ {
			tid := layer.get_tileid(x, y)
			if tid >= 0 {
				if map.has_tileset_tile(tid.id()) {
					tileset_tile := map.tileset_tile(tid.id())
					// ignore oneway platforms and slopse
					if tileset_tile.oneway || tileset_tile.slope {
						continue
					}
				}

				// worldx is the LEFT of the tile
				worldx := map.tile_to_worldx(x)

				// moving left
				if movex < 0 {
					return worldx + map.tile_size - rect.x
				} else {
					return worldx - rect.right()
				}
			}
		}
	}
	return movex
}

pub fn movey(map &Map, layer &TileLayer, rect math.Rect, movey int) int {
	edge := if movey >= 0 { math.Edge.bottom } else { math.Edge.top }
	mut bounds := rect.half_rect(edge)
	// we contract horizontally for vertical movement and vertically for horizontal movement
	bounds.contract(horiz_inset, 0)
	// finally expand the side in the direction of movement
	bounds.expand_edge(edge, movey)

	minx := map.world_to_tilex(bounds.x)
	miny := map.world_to_tiley(bounds.y)
	maxx := map.world_to_tilex(bounds.right())
	maxy := map.world_to_tiley(bounds.bottom())

	for x := minx; x <= maxx; x++ {
		for y := miny; y <= maxy; y++ {
			tid := layer.get_tileid(x, y)
			if tid >= 0 {
				if map.has_tileset_tile(tid.id()) {
					tileset_tile := map.tileset_tile(tid.id())
					if tileset_tile.oneway {
						// allow movement up always
						if movey < 0 {
							continue
						}
						// allow movement down if our bottom is not above the tile
						if map.tile_to_worldy(y) < rect.bottom() {
							continue
						}
					}
				}

				// worldy is the TOP of the tile
				worldy := map.tile_to_worldy(y)

				// moving up
				if movey < 0 {
					return worldy + map.tile_size - rect.y
				} else {
					return worldy - rect.bottom()
				}
			}
		}
	}
	return movey
}