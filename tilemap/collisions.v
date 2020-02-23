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

	debuggy(map, bounds, edge)

	for x := minx; x <= maxx; x++ {
		for y := miny; y <= maxy; y++ {
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
	}
	return movey
}

fn debuggy(map Map, bounds math.Rect, edge math.Edge) {
	minx := map.world_to_tilex(bounds.x)
	miny := map.world_to_tiley(bounds.y)
	maxx := map.world_to_tilex(bounds.right())
	maxy := map.world_to_tiley(bounds.bottom())

	mut incr := 1
	if edge == .bottom {

	}

	mut tile_cnt := 0
	for y := miny; y <= maxy; y += incr {
		for x := minx; x <= maxx; x += incr {
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
	}

	is_h := edge.horizontal()
	prim_axis := math.take(is_h, math.Axis.x, math.Axis.y)
	op_axis := math.take(prim_axis == .x, math.Axis.y, math.Axis.x)

	op_dir := edge.opposing()
	frst_prim := world_to_tile(map, bounds.side(op_dir), prim_axis)
	lst_prim := world_to_tile(map, bounds.side(edge), prim_axis)
	prim_incr := math.take(edge.max(), 1, -1)

	min := world_to_tile(map, math.take(is_h, bounds.top(), bounds.left()), op_axis)
	mid := world_to_tile(map, math.take(is_h, bounds.centery(), bounds.centerx()), op_axis)
	max := world_to_tile(map, math.take(is_h, bounds.bottom(), bounds.right()), op_axis)

	is_pos := mid - min < max - mid
	secondary_incr := math.take(is_pos, 1, -1)
	frst_secondary := math.take(is_pos, min, max)
	lst_secondary := math.take(!is_pos, min, max)

	//println('-- primary: $frst_prim -> $lst_prim	secondary: $frst_secondary -> $lst_secondary')
	//println('-- x: $minx -> $maxx	y: $miny -> $maxy')

	println('--- is_h($is_h) $frst_prim -> $lst_prim ($prim_incr)  $frst_secondary -> $lst_secondary ($secondary_incr) ---------------------')
	for primary := frst_prim; primary != lst_prim + prim_incr; primary += prim_incr {
		for secondary := frst_secondary; secondary != lst_secondary + secondary_incr; secondary += secondary_incr {
			col := math.take(is_h, primary, secondary)
			row := math.take(!is_h, primary, secondary)
			println('-- $col,$row --')
		}
	}
}

fn world_to_tile(map Map, pos int, axis math.Axis) int {
	return math.take(axis == .x, map.world_to_tilex(pos), map.world_to_tiley(pos))
}