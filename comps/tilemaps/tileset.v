module tilemaps

pub struct Property {
pub:
	key string
	value string
}

pub struct Tileset {
mut:
	spacing int
	margin int
	image string
	tiles []TilesetTile // TODO: should this be an IntHashMap? double check to ensure TilesetTiles are assigned a 0-based index.
}

pub fn (t Tileset) str() string {
	return 's:$t.spacing, m:$t.margin, image:$t.image, tiles:$t.tiles.len'
}

pub fn (t &Tileset) free() {
	unsafe { t.tiles.free() }
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
pub:
	id int // TODO: do we need this? id should always be array index for non-image tilesets
	props []Property
	//props map[string]string
}
