module tilemap
import via.utils.jsmn

pub fn load(js []byte) Map {
	mut p := jsmn.parser(true)
	if p.parse(js) < 0 {
		panic('tilemap parse error')
	}

	mut m := Map{
		width: p.tokens[2].as_int(js)
		height: p.tokens[4].as_int(js)
		tile_size: p.tokens[6].as_int(js)
	}

	for i in 0..p.tokens[8].size {
		m.tilesets << parse_tileset(js, jsmn.array_get_at(&p.tokens[8], i))
	}

	tile_layers_arr := jsmn.object_get_member(js, &p.tokens[0], 'tile_layers')
	for i in 0..tile_layers_arr.size {
		m.tile_layers << parse_tilelayer(js, jsmn.array_get_at(tile_layers_arr, i))
	}

	obj_layers_arr := jsmn.object_get_member(js, &p.tokens[0], 'object_layers')
	for i in 0..obj_layers_arr.size {
		m.object_layers << parse_objectlayer(js, jsmn.array_get_at(obj_layers_arr, i))
	}

	return m
}

fn parse_tileset(js []byte, tokens &jsmn.Token) Tileset {
	mut ts := Tileset{
		tile_size: tokens[2].as_int(js)
		spacing: tokens[4].as_int(js)
		margin: tokens[6].as_int(js)
		image: tokens[8].as_str(js).clone()
		image_columns: tokens[10].as_int(js)
	}

	tiles_arr_tok := &tokens[12]
	for i in 0..tiles_arr_tok.size {
		tile_tok := jsmn.array_get_at(tiles_arr_tok, i)
		if tile_tok == 0 {
			panic('failed to get array index $i')
		}

		mut tile := TilesetTile{
			id: tile_tok[2].as_int(js)
		}

		prop_arr_tok := &tile_tok[4]
		for j in 0..prop_arr_tok.size {
			prop_tok := jsmn.array_get_at(prop_arr_tok, j)
			tile.props << Property{
				key: prop_tok[2].as_str(js).clone()
				value: prop_tok[4].as_str(js).clone()
			}
		}

		ts.tiles << tile
	}

	return ts
}

fn parse_tilelayer(js []byte, tokens &jsmn.Token) TileLayer {
	tiles_arr_tok := &tokens[10]

	mut tl := TileLayer{
		name: tokens[2].as_str(js)
		visible: tokens[4].as_str(js).bool()
		width: tokens[6].as_int(js)
		height: tokens[8].as_int(js)
		tiles: make(0, tiles_arr_tok.size, sizeof(int))
	}

	for i in 0..tiles_arr_tok.size {
		// array of ints so we know the next token is always the next element
		tl.tiles << tiles_arr_tok[i + 1].as_int(js)
	}

	return tl
}

fn parse_objectlayer(js []byte, tokens &jsmn.Token) ObjectLayer {
	mut ol := ObjectLayer{
		name: tokens[2].as_str(js).clone()
		visible: tokens[4].as_str(js).bool()
	}

	objects_arr_tok := &tokens[6]
	for i in 0..objects_arr_tok.size {
		obj_tok := jsmn.array_get_at(objects_arr_tok, i)
		ol.objects << Object{
			id: obj_tok[2].as_int(js)
			name: obj_tok[4].as_str(js).clone()
			shape: obj_tok[6].as_int(js)
			x: obj_tok[8].as_f32(js)
			y: obj_tok[10].as_f32(js)
			w: obj_tok[12].as_f32(js)
			h: obj_tok[14].as_f32(js)
		}
	}

	return ol
}