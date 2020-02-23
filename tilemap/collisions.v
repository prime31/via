module tilemap
import via.math
import via.debug

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

	mut iter := mapcollisioniter(map, bounds, edge)
	for iter.next() {
		x, y := iter.current()
		tid := layer.get_tileid(x, y)
		if tid >= 0 {
			if map.has_tileset_tile(tid.id()) {
				tileset_tile := map.tileset_tile(tid.id())
				// ignore oneway platforms and slopes
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

	return movex
}

pub fn movey(map &Map, layer &TileLayer, rect math.Rect, movey int) int {
	edge := if movey >= 0 { math.Edge.bottom } else { math.Edge.top }
	mut bounds := rect.half_rect(edge)
	// we contract horizontally for vertical movement and vertically for horizontal movement
	bounds.contract(horiz_inset, 0)
	// finally expand the side in the direction of movement
	bounds.expand_edge(edge, movey)

	debug_overlaps(map, bounds, edge)

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
				} else if tileset_tile.slope && edge == .bottom {
					perp_pos := bounds.centerx()
					tile_worldx := map.tile_to_worldx(x)

					// only process the slope if our center is within the tiles bounds
					if math.between(perp_pos, tile_worldx, tile_worldx + map.tile_size) {
						tile_worldy := map.tile_to_worldy(y)
						slope_posy := tileset_tile.name_me(tid, map.tile_size, int(perp_pos), tile_worldx, tile_worldy)

						println('-- sloping: tile_worldy: $tile_worldy, slope_posy: $slope_posy')
						debug.draw_line(tile_worldx, tile_worldy, tile_worldx + 16, tile_worldy, 1, math.color_black())

						// debug.draw_point(perp_pos, tile_worldy, 4, math.color_blue())
						debug.draw_point(perp_pos, slope_posy, 2, math.color_white())
						debug.draw_point(perp_pos, rect.bottom(), 2, math.color_orange())
						debug.draw_point(perp_pos, bounds.bottom(), 2, math.color_purple())
						if bounds.bottom() <= slope_posy {
							return slope_posy - rect.bottom()
						}
					}
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

fn debug_overlaps(map Map, bounds math.Rect, edge math.Edge) {
	mut tile_cnt := 0
	mut iter := mapcollisioniter(map, bounds, edge)
	for iter.next() {
		x, y := iter.current()
		xw := map.tile_to_worldx(x)
		yw := map.tile_to_worldy(y)
		color := match tile_cnt {
			0 { math.color_yellow() }
			1 { math.color_red() }
			2 { math.color_blue() }
			3 { math.color_black() }
			else { math.color_yellow() }
		}
		debug.draw_hollow_rect(xw, yw, 16, 16, 1, color)
		tile_cnt++
	}

	// for y := miny; y <= maxy; y += incr {
	// 	for x := minx; x <= maxx; x += incr {
	// 		xw := map.tile_to_worldx(x)
	// 		yw := map.tile_to_worldy(y)
	// 		color := match tile_cnt {
	// 			0 { math.color_yellow() }
	// 			1 { math.color_red() }
	// 			2 { math.color_blue() }
	// 			3 { math.color_black() }
	// 			else { math.color_yellow() }
	// 		}
	// 		debug.draw_hollow_rect(xw, yw, 16, 16, 1, color)
	// 		tile_cnt++
	// 	}
	// }
}
