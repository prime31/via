module tilemap
import via.math
import via.graphics

// note: does not free the Textures
pub struct MapRenderer {
	map Map
mut:
	textures []graphics.Texture
}

pub fn maprenderer(map Map) MapRenderer {
	mut renderer :=  MapRenderer{
		map: map
	}

	// load textures required by the Tilesets
	for tx in map.tilesets {
		renderer.textures << graphics.new_texture(tx.image)
	}

	return renderer
}

pub fn (m &MapRenderer) free() {
	unsafe {
		m.textures.free()
	}
}

pub fn (m &MapRenderer) render() {
	for tl in m.map.tile_layers {
		if tl.visible {
			m.render_tilelayer(tl)
		}
	}

	for ol in m.map.object_layers {
		if ol.visible {
			m.render_objectlayer(ol)
		}
	}
}

// TODO: this duplicates tilelayer_atlasbatch but generics dont let us abstract it yet
pub fn (m &MapRenderer) render_tilelayer(layer &TileLayer) {
	mut batch := graphics.spritebatch()
	// TODO: multiple Tileset support instead of just using the first tilesets image
	tex := m.textures[0]

	mut i := 0
	for y in 0..layer.height {
		for x in 0..layer.width {
			tile_id := layer.tiles[i++]
			if tile_id >= 0 {
				tile := tile(tile_id, m.map.tile_size)
				vp := m.map.tilesets[0].viewport_for_tile(tile.id)

				tx := f32(x * m.map.tile_size) + tile.ox * 1.0
				ty := f32(y * m.map.tile_size) + tile.oy * 1.0
				batch.draw_vp(tex, vp, {x:tx y:ty rot:tile.rot sx:tile.sx sy:tile.sy ox:tile.ox oy:tile.oy})
			}
		}
	}
}

// returns an AtlasBatch with the TileLayer's tiles added to it
pub fn (m &MapRenderer) tilelayer_atlasbatch(layer &TileLayer) &graphics.AtlasBatch {
	tex := m.textures[0]
	mut batch := graphics.new_atlasbatch(tex, layer.total_non_empty_tiles())

	mut i := 0
	for y in 0..layer.height {
		for x in 0..layer.width {
			tile_id := layer.tiles[i++]
			if tile_id >= 0 {
				tile := tile(tile_id, m.map.tile_size)
				vp := m.viewport_for_tile(tile.id)

				tx := f32(x * m.map.tile_size) + tile.ox * 1.0
				ty := f32(y * m.map.tile_size) + tile.oy * 1.0
				batch.add_vp(vp, {x:tx y:ty rot:tile.rot sx:tile.sx sy:tile.sy ox:tile.ox oy:tile.oy})
			}
		}
	}
	return batch
}

pub fn (m &MapRenderer) render_objectlayer(layer &ObjectLayer) {
	mut tribatch := graphics.tribatch()
	mut batch := graphics.spritebatch()

	for obj in layer.objects {
		match obj.shape {
			box {
				tribatch.draw_hollow_rect(obj.x, obj.y, obj.w, obj.h, 1, math.color_red())
			}
			circle {
				rad := obj.w / 2
				tribatch.draw_hollow_circle(rad, 10, {x:obj.x + rad y:obj.y + rad color:math.color_red()})
			}
			ellipse {
				rad := obj.w / 2
				tribatch.draw_hollow_circle(rad, 10, {x:obj.x + rad y:obj.y + rad color:math.color_orange()})
			}
			point {
				tribatch.draw_point(obj.x, obj.y, 6, math.color_red())
			}
			polygon {
				println('polygon not implemented')
			}
			else {}
		}

		tribatch.flush()
		if obj.name.len > 0 {
			batch.draw_text(obj.name, {x:obj.x y:obj.y align:.default fontbook:0})
		}
	}
}
