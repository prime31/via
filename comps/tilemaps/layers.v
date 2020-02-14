module tilemaps

//#region ObjectLayer

pub struct ObjectLayer {
pub mut:
	name string
	visible bool
	objects []Object
}

pub fn (o ObjectLayer) str() string {
	return 'n:$o.name, v:$o.visible, objects:$o.objects.len'
}

pub fn (o &ObjectLayer) free() {
	unsafe {
		o.objects.free()
	}
}

//#endregion

//#region ImageLayer

pub struct ImageLayer {
pub mut:
	name string
	visible bool
	source string
}

pub fn (i &ImageLayer) free() {
	unsafe {
		i.name.free()
		i.source.free()
	}
}

//#endregion

//#region GroupLayer

pub struct GroupLayer {
pub mut:
	name string
	visible bool
	tile_layers []TileLayer
	object_layers []ObjectLayer
	//group_layers []GroupLayer // TODO: JSON cant handle this yet
}

pub fn (g GroupLayer) str() string {
	return 'n:$g.name, v:$g.visible, tile_layers:$g.tile_layers, object_layers:$g.object_layers'
}

pub fn (g &GroupLayer) free() {
	unsafe {
		for tl in g.tile_layers { tl.free() }
		for ol in g.object_layers { ol.free() }

		g.tile_layers.free()
		g.object_layers.free()
	}
}

//#endregion