const FLIPPED_HORIZONTALLY_FLAG = 0x80000000;
const FLIPPED_VERTICALLY_FLAG = 0x40000000;
const FLIPPED_DIAGONALLY_FLAG = 0x20000000;

var vMapFormat = {
    name: 'V Tiled Format',
    extension: 'json',

	getTileId: function(cell) {
		var id = cell.tileId;
		if (cell.flippedAntiDiagonally)
			id += FLIPPED_HORIZONTALLY_FLAG;
		if (cell.flippedVertically)
			id += FLIPPED_VERTICALLY_FLAG;
		if (cell.flippedDiagonally)
			id += FLIPPED_DIAGONALLY_FLAG;
		return id;
	},

	cleanImagePath: function(path) {
		return path.split('\\').pop().split('/').pop();
	},

	getTileset: function(tileset) {
		var ts = {
			spacing: tileset.tileSpacing,
			margin: tileset.margin,
			image: vMapFormat.cleanImagePath(tileset.image),
			tiles: []
		};

		for (var j = 0; j < tileset.tiles.length; j++) {
			var tile = tileset.tiles[j];
			var props = []

			if (Object.keys(tile.properties()).length > 0) {
				for (let key in tile.properties()) {
					props.push({
						key: key,
						value: tile.property(key)
					})
				}
			}

			ts.tiles.push({
				id: tile.id,
				props: props
			});
		}

		return ts;
	},

	getTileLayer: function(layer) {
		var l = {
			name: layer.name,
			visible: layer.visible,
			width: layer.width,
			height: layer.height,
			tiles: []
		};

        for (var y = 0; y < layer.height; y++) {
            for (var x = 0; x < layer.width; x++) {
				var id = vMapFormat.getTileId(layer.cellAt(x, y));
				l.tiles.push(id);
            }
        }

		return l;
	},

	getGroupLayer: function(layer) {
		var l = {
			name: layer.name,
			visible: layer.visible,
			tile_layers: [],
			object_layers: []
		};

		for (var i = 0; i < layer.layerCount; i++) {
			var subLayer = layer.layerAt(i);
			if (subLayer.isTileLayer) {
				l.tile_layers.push(vMapFormat.getTileLayer(subLayer));
			} else if (subLayer.isGroupLayer) {
				tiled.warn('GroupLayers inside GroupLayers are not supported. Ignoring.');
            } else if (subLayer.isObjectGroup) {
				throw 'layer.isObjectGroup is true. This wasnt previously possible.';
			} else if (subLayer.isImageLayer) {
				tiled.warn('ImageLayers inside GroupLayers are not supported. Ignoring.');
			} else {
				l.object_layers.push(vMapFormat.getObjectLayer(subLayer));
			}
		}

		return l;
	},

	getObjectLayer: function(layer) {
		var l = {
			name: layer.name,
			visible: layer.visible,
			objects: []
		};

		for (var j = 0; j < layer.objects.length; j++) {
			var object = layer.objects[j];
			l.objects.push({
				id: object.id,
				name: object.name,
				shape: object.shape == 3 && object.w == object.h ? 1 : object.shape,
				x: object.x,
				y: object.y,
				w: object.width,
				h: object.height
			});
		}

		return l;
	},

    write: function(map, fileName) {
        var m = {
            width: map.width,
            height: map.height,
			tile_size: map.tileWidth,
            tilesets: [],
			tile_layers: [],
			object_layers: [],
			group_layers: [],
			image_layers: []
        };

		tiled.log("------------- V export -------------");

		tiled.log(`exporting ${map.usedTilesets().length} tilesets`);
		var tilesets = map.usedTilesets();
		for (var i = 0; i < tilesets.length; i++) {
			var tileset = tilesets[i];
			m.tilesets.push(vMapFormat.getTileset(tileset));
		}

		tiled.log(`exporting ${map.layerCount} layers`);
        for (var i = 0; i < map.layerCount; i++) {
            var layer = map.layerAt(i);

            if (layer.isTileLayer) {
				m.tile_layers.push(vMapFormat.getTileLayer(layer));
            } else if (layer.isObjectGroup) {
				throw 'layer.isObjectGroup is true. This wasnt previously possible.';
			} else if (layer.isImageLayer) {
				tiled.warn('ImageLayers not supported. Ignoring.');
			} else if (layer.isGroupLayer) {
				m.group_layers.push(vMapFormat.getGroupLayer(layer));
			} else {
				m.object_layers.push(vMapFormat.getObjectLayer(layer));
			}
        }

		var file = new TextFile(fileName, TextFile.WriteOnly);
		file.write(JSON.stringify(m, null, 4));
        file.commit();
    },
}

tiled.registerMapFormat('V', vMapFormat)

var action = tiled.registerAction('Export V', function(action) {
    tiled.trigger('ExportAs');
})

action.text = 'Export V Map'
action.shortcut = 'Ctrl+K'

tiled.extendMenu("Edit", [
    { action: 'Export V', before: 'SelectAll' },
    { separator: true }
]);