module tilemaps
import via.math
import via.graphics

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

	// for id in map.tile_layers[0].tiles {
	// 	if id > 4 {
	// 		println('------ $id ')
	// 	}
	// }

	return renderer
}

pub fn (m &MapRenderer) free() {
	unsafe {
		for t in m.textures { t.free() }
		m.textures.free()
	}
}

pub fn (m &MapRenderer) render() {
	for tl in m.map.tile_layers {
		m.render_tilelayer(tl)
	}
}

pub fn (m &MapRenderer) render_tilelayer(layer &TileLayer) {
	mut batch := graphics.spritebatch()
	mut i := 0
	for y in 0..layer.height {
		for x in 0..layer.width {
			tile_id := layer.tiles[i++]
			if tile_id >= 0 {
				mut tile := tile(tile_id, m.map.tile_size)
				vp := tile.viewport(m.textures[0].w, m.textures[0].w, m.map.tile_size, m.map.tilesets[0].spacing, m.map.tilesets[0].margin)

				tx := x * m.map.tile_size
				ty := y * m.map.tile_size
				// TODO: rotated/scaled (ie ox/oy != 0) needs to have x/y bumped to match the offset
				batch.draw_vp(m.textures[0], vp, {x:tx y:ty rot:tile.rot sx:tile.sx sy:tile.sy ox:tile.ox oy:tile.oy})
			}
		}
	}
}