module jsmn

fn C.strncmp() int

// return next token, ignoring descendants
fn skip_token(token &Token) &Token {
	mut tok := token
	mut pending := 1
	for pending > 0 {
		pending += tok.size - 1
		tok = &Token(int(tok)+1)
	}

	return tok
}

// find the first member with the given name
pub fn object_get_member(js []byte, object &Token, name string) &Token {
	if object == 0 || object.kind != .object {
		return &Token(0)
	}

	mut members := object.size
	mut token := &Token(int(object) + 1)
	for members > 0 && !token.eq(js, name) {
		members--
		token = &Token(skip_token((int(token) + 1)))
	}

	if members == 0 {
		return &Token(0)
	}
	return int(token) + 1
}

// find the element at the given position of an array (starting at 0)
pub fn array_get_at(arr &Token, index int) &Token {
	if arr == 0 || arr.kind != .array || index < 0 || arr.size <= index {
		return &Token(0)
	}

	mut token := &Token(int(arr) + 1)
	for i := 0; i < index; i++ {
		token = skip_token(token)
	}
	return token
}

// result dumper that prints to the console all the tokens in a YAML-like way
pub fn dump(js []byte, tokens &Token, count int, indent int) int {
	if count == 0 {
		return 0
	}

	mut j := 0
	match tokens.kind {
		.number, .bool, .null {
			unsafe {
				s := js[tokens.start..tokens.end - tokens.start].bytestr() //string(&js[tokens.start], tokens.end - tokens.start)
				print('$s')
			}
			return 1
		}
		.string {
			unsafe {
				s := js[tokens.start..tokens.end - tokens.start].bytestr() //string(&js[tokens.start], tokens.end - tokens.start)
				print(s)
			}
			return 1
		}
		.object {
			println('')
			for _ in 0..tokens.size {
				for _ in 0..indent {
					print('\t')
				}
				key := tokens[1 + j]
				j += dump(js, &key, count - j, indent + 1)
				if key.size > 0 {
					print(': ')
					j += dump(js, &tokens[1 + j], count - j, indent + 1)
				}
				println('')
			}
			return j + 1
		}
		.array {
			j = 0
			println('')
			for _ in 0..tokens.size {
				for _ in 0..indent - 1 {
					print('	')
				}
				print('	- ')
				j += dump(js, &tokens[j + 1], count - j, indent + 1)
				println('')
			}
			return j + 1
		}
		else {}
	}
	return 0
}