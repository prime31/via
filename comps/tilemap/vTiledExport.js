const FLIPPED_HORIZONTALLY_FLAG = 0x08000000;
const FLIPPED_VERTICALLY_FLAG = 0x04000000;
const FLIPPED_DIAGONALLY_FLAG = 0x02000000;

var vMapFormat = {
    name: 'V Tiled Format',
    extension: 'json',
	images: [],
	tilesetTiles: {},

	getPngColumnCount: function(tileset) {
		var png = new BinaryFile(tileset.image, BinaryFile.ReadOnly);
		png.seek(16);
		var dvW = new DataView(png.read(4));
		var dvH = new DataView(png.read(4));
		var width = dvW.getUint32();
		var height = dvH.getUint32();
		png.close();

		// determine number of columns in the image
		var columns = 0;
		var accum_w = tileset.margin * 2;
		while (true) {
			columns++
			accum_w += tileset.tileWidth + 2 * tileset.tileSpacing
			if (accum_w >= width) {
				return columns;
			}
		}
		return columns;
	},

	getTileId: function(cell, flags) {
		var id = cell.tileId;

		// it seems these bools arent properly set all the time so we use flags instead
		if (cell.flippedAntiDiagonally || cell.flippedVertically || cell.flippedDiagonally) {
			if (cell.flippedAntiDiagonally)
				id += FLIPPED_HORIZONTALLY_FLAG;
			if (cell.flippedVertically)
				id += FLIPPED_VERTICALLY_FLAG;
			if (cell.flippedDiagonally)
				id += FLIPPED_DIAGONALLY_FLAG;
		} else if (flags > 0) {
			if (flags == 1)
				id += FLIPPED_HORIZONTALLY_FLAG;
			if (flags == 2)
				id += FLIPPED_VERTICALLY_FLAG;
			if (flags == 3)
				id += FLIPPED_DIAGONALLY_FLAG;
		}

		return id;
	},

	cleanImagePath: function(path) {
		vMapFormat.images.push(path);
		return path.split('\\').pop().split('/').pop();
	},

	getTileset: function(tileset) {
		var ts = {
			spacing: tileset.tileSpacing,
			margin: tileset.margin,
			image: vMapFormat.cleanImagePath(tileset.image),
			image_columns: vMapFormat.getPngColumnCount(tileset),
			tiles: []
		};

		for (var j = 0; j < tileset.tiles.length; j++) {
			var tile = tileset.tiles[j];
			var tileHasData = false;
			var props = []

			if (Object.keys(tile.properties()).length > 0) {
				tileHasData = true;
				for (let key in tile.properties()) {
					props.push({
						key: key,
						value: tile.property(key).toString()
					})
				}
			}

			if (tile.frames.length > 0) {
				tileHasData = true;
				tiled.log('we have animation frames');
			}

			if (tileHasData) {
				tiled.warn(`adding tileset tile: ${tile.id} => ${Object.keys(vMapFormat.tilesetTiles).length}`);
				vMapFormat.tilesetTiles[tile.id] = Object.keys(vMapFormat.tilesetTiles).length;
				ts.tiles.push({
					id: tile.id,
					props: props
				});
			}
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
				var id = vMapFormat.getTileId(layer.cellAt(x, y), layer.flagsAt(x, y));
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
				shape: object.shape == 3 && object.width == object.height ? 1 : object.shape,
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
		file.write(JSON.stringify(m));
        file.commit();

		// copy over our images
		var dstFolder = fileName.substring(0, fileName.lastIndexOf("/"));
		for (var i = 0; i < vMapFormat.images.length; i++) {
			var src = vMapFormat.images[i];
			var filename = src.split('\\').pop().split('/').pop();
			var dst = dstFolder + '/' + filename;

			tiled.log('copying ' + src + ' to ' + dst);
			var srcFile = new BinaryFile(src, BinaryFile.ReadOnly);
			var bytes = srcFile.readAll();

			var dstFile = new BinaryFile(dst, BinaryFile.WriteOnly);
			dstFile.write(bytes);
			dstFile.commit();

			srcFile.close();
		}
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
