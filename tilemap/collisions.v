module tilemap
import via.math
import via.debug

const (
	// the inset on the horizontal plane that the BoxCollider will be shrunk by when moving vertically
	horiz_inset = 2
	// the inset on the vertical plane that the BoxCollider will be shrunk by when moving horizontally
	vert_inset = 2
)

pub fn move(map &Map, rect math.Rect, mut movement math.Vec2) {
	layer := map.tile_layers[0]
	mut rectm := rect

	if movement.x != 0 {
		movement.x = movex(map, layer, rectm, int(movement.x))
		rectm.x += int(movement.x)
	}
	movement.y = movey(map, layer, rectm, int(movement.y))
}

pub fn movex(map &Map, layer &TileLayer, rect math.Rect, movex int) int {
	edge := math.take(movex > 0, math.Edge.right, math.Edge.left)
	mut bounds := rect.half_rect(edge)
	// we contract horizontally for vertical movement and vertically for horizontal movement
	bounds.contract(0, vert_inset)
	// finally expand the side in the direction of movement
	bounds.expand_edge(edge, movex)

	// debug_overlaps(map, bounds, edge)

	// keep track of any rows with slopes. We use this info to ignore collisions that occur with tiles behind slopes (inaccessible)
	mut slope_rows := [-1, -1, -1]!!
	mut last_slope_row := 0

	mut iter := mapcollisioniter(map, bounds, edge)
	for iter.next() {
		x, y := iter.current()
		tid := layer.get_tileid(x, y)
		if tid >= 0 {
			if map.has_tileset_tile(tid.id()) {
				tileset_tile := map.tileset_tile(tid.id())
				// ignore oneway platforms and slopes
				if tileset_tile.oneway {
					continue
				} else if tileset_tile.slope {
					last_slope_row++
					slope_rows[last_slope_row] = y
					continue
				}
			}

			if in_c_arr(y, &slope_rows[0], last_slope_row) {
				continue
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

	return movex
}

pub fn movey(map &Map, layer &TileLayer, rect math.Rect, movey int) int {
	edge := math.take(movey >= 0, math.Edge.bottom, math.Edge.top)
	mut bounds := rect.half_rect(edge)
	// we contract horizontally for vertical movement and vertically for horizontal movement
	bounds.contract(horiz_inset, 0)
	// finally expand the side in the direction of movement
	bounds.expand_edge(edge, movey)

	// debug_overlaps(map, bounds, edge)

	mut iter := mapcollisioniter(map, bounds, edge)
	for iter.next() {
		x, y := iter.current()
		tid := layer.get_tileid(x, y)
		if tid >= 0 {
			if map.has_tileset_tile(tid.id()) {
				tileset_tile := map.tileset_tile(tid.id())
				if tileset_tile.oneway {
					// allow movement up always
					if edge == .top {
						continue
					}
					// allow movement down if our bottom is not above the tile
					if map.tile_to_worldy(y) < rect.bottom() {
						continue
					}
				} else if tileset_tile.slope {
					perp_pos := bounds.centerx()
					tile_worldx := map.tile_to_worldx(x)

					// only process the slope if our center is within the tiles bounds
					if math.between(perp_pos, tile_worldx, tile_worldx + map.tile_size) {
						leading_edge_pos := bounds.side(edge)
						tile_worldy := map.tile_to_worldy(y)
						slope_posy := tileset_tile.name_me(tid, map.tile_size, perp_pos, tile_worldx, tile_worldy)

						if leading_edge_pos >= slope_posy {
							return slope_posy - rect.bottom()
						}
						return movey
					}
					continue
				}
			}

			// worldy is the TOP of the tile
			worldy := map.tile_to_worldy(y)

			// moving up
			if edge == .top {
				return worldy + map.tile_size - rect.y
			} else {
				return worldy - rect.bottom()
			}
		}
	}

	return movey
}

fn in_c_arr(val int, arr &int, len int) bool {
	for i in 0..len {
		if arr[i] == val {
			return true
		}
	}
	return false
}

fn debug_overlaps(map Map, bounds math.Rect, edge math.Edge) {
	mut tile_cnt := 0
	mut iter := mapcollisioniter(map, bounds, edge)
	for iter.next() {
		x, y := iter.current()
		xw := map.tile_to_worldx(x)
		yw := map.tile_to_worldy(y)
		color := match tile_cnt {
			0 { math.yellow() }
			1 { math.red() }
			2 { math.blue() }
			3 { math.black() }
			else { math.orange() }
		}
		debug.draw_hollow_rect(xw, yw, 16, 16, 1, color)
		tile_cnt++
	}
}
