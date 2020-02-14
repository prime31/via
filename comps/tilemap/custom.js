const FLIPPED_HORIZONTALLY_FLAG = 0x80000000;
const FLIPPED_VERTICALLY_FLAG = 0x40000000;
const FLIPPED_DIAGONALLY_FLAG = 0x20000000;

var customMapFormat = {
    name: "V Tiled Format",
    extension: "txt",
	
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

    write: function(map, fileName) {
        var m = {
            width: map.width,
            height: map.height,
			tileSize: map.tileWidth,
            layers: []
        };
		
		var file = new TextFile(fileName, TextFile.WriteOnly);
		tiled.log("------------- V export -------------");
		file.writeLine("// map");
		file.writeLine(`width: ${map.width}`);
		file.writeLine(`height: ${map.height}`);
		file.writeLine(`tile_size: ${map.tileWidth}`);
		
		file.writeLine("\n// tilesets");
		var tilesets = map.usedTilesets();
		for (var i = 0; i < tilesets.length; i++) {
			var tileset = tilesets[i];
			file.writeLine(`tileset ${i}`);
			file.writeLine(`	spacing: ${tileset.tileSpacing}`);
			file.writeLine(`	margin: ${tileset.margin}`);
			file.writeLine(`	image: ${tileset.image}`);

			file.writeLine('\n	// tiles');
			for (var j = 0; j < tileset.tiles.length; j++) {
				var tile = tileset.tiles[j];
				file.writeLine(`	id: ${tile.id}`);

				if (Object.keys(tile.properties()).length == 0) {
					file.writeLine('		properties: null');
				} else {
					for (let key in tile.properties()) {
						file.writeLine(`		${key} = ${tile.property(key)}`);
					}	
				}
			}
		}

		file.writeLine(`\n// layers ${map.layerCount}`);
        for (var i = 0; i < map.layerCount; ++i) {
            var layer = map.layerAt(i);
			file.writeLine(`layer ${i}`);
			file.writeLine(`	name: ${layer.name}`);
			file.writeLine(`	visible: ${layer.visible}`);

            if (layer.isTileLayer) {
				file.writeLine('	type: TileLayer');
				file.writeLine(`	width: ${layer.width}`);
				file.writeLine(`	height: ${layer.height}`);
				file.write('	data: ');

				var tiles = [];
                for (y = 0; y < layer.height; y++) {
                    for (x = 0; x < layer.width; x++) {
						var id = customMapFormat.getTileId(layer.cellAt(x, y))
						tiles.push(id);
						// TODO: probably dont need to bit fiddle the id. We can directly write the bools.
                    }
                }
				file.write(JSON.stringify(tiles));
				file.writeLine('');
            } else if (layer.isObjectGroup) {
				file.writeLine('	type: ObjectGroupLayer');
			} else if (layer.isGroupLayer) {
				file.writeLine('	type: GroupLayer');
			} else {
				file.writeLine('	type: ObjectLayer');
				file.writeLine('	objects:');
				for (var i = 0; i < layer.objects.length; i++) {
					var object = layer.objects[i];
					// shapes. 3: ellipse, 0: rectangle, 5: point, 11: polygon
					file.writeLine(`		object id: ${object.id}`);
					file.writeLine(`			name: ${object.name}`);
					file.writeLine(`			shape: ${object.shape}`);
					file.writeLine(`			x: ${object.x}`);
					file.writeLine(`			y: ${object.y}`);
					file.writeLine(`			width: ${object.width}`);
					file.writeLine(`			height: ${object.height}`);
					tiled.log(object.polygon);
				}
			}
        }

        file.commit();
    },
}

tiled.registerMapFormat("V", customMapFormat)

var action = tiled.registerAction("Export V", function(action) {
    tiled.trigger("ExportAs");
	// tiled.executeCommand("V");
})

action.text = "Export V Map"
action.shortcut = "Ctrl+K"

tiled.extendMenu("Edit", [
    { action: "Export V", before: "SelectAll" },
    { separator: true }
]);