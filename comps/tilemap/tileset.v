module tilemap

pub struct Tileset {
	spacing int
	margin int
	image string
	tiles []TilesetTile // TODO: should this be an IntHashMap? double check to ensure TilesetTiles are assigned a 0-based index.
}

/* cache the Viewports for each tile
var id = firstGid;
for (var y = tileset.Margin; y < tileset.Image.Height - tileset.Margin; y += tileset.TileHeight + tileset.Spacing)
{
	var column = 0;
	for (var x = tileset.Margin; x < tileset.Image.Width - tileset.Margin; x += tileset.TileWidth + tileset.Spacing)
	{
		tileset.TileRegions.Add(id++, new RectangleF(x, y, tileset.TileWidth, tileset.TileHeight));

		if (++column >= tileset.Columns)
			break;
	}
}*/


pub struct TilesetTile {
	id int // TODO: do we need this? id should always be array index for non-image tilesets
	props map[string]string
}
