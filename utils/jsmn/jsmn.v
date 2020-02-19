module jsmn
import strconv

fn C.atoi(byteptr) int

// V port of the fantastic jsmn: https://github.com/zserge/jsmn
// includes some additions such as a non-strict mode that doesnt require commas

// example of a state-machine to handle the parse results: https://alisdair.mcdiarmid.org/jsmn-example/
enum Kind {
	undefined
	object
	array
	string
	number
	bool
	null
}

pub enum Error {
	no_error = 0
	no_memory = -1			// Not enough tokens were provided
	invalid_char = -2	// Invalid character inside JSON string
	partial_packet = -3		// The string is not a full JSON packet, more bytes expected
}

pub struct Token {
pub mut:
	kind Kind		// Kind (object, array, string etc.)
	start int = -1	// start position in JSON data string
	end int = -1	// end position in JSON data string
	size int		// size of arrays and objects
	parent int = -1	// parent token index
}

pub fn (t &Token) str() string {
	return 'kind:$t.kind, start:$t.start, end:$t.end, size:$t.size, parent:$t.parent'
}

[inline]
pub fn (t &Token) as_str(js []byte) string {
	return string(&js[t.start], t.end - t.start)
}

[inline]
pub fn (t &Token) as_int(js []byte) int {
	return C.atoi(string(&js[t.start], t.end - t.start).str)
	// return strconv.atoi(string(&js[t.start], t.end - t.start))
}

[inline]
pub fn (t &Token) as_f32(js []byte) f32 {
	return f32(C.atof(string(&js[t.start], t.end - t.start).str))
	// return f32(strconv.atof64(string(&js[t.start], t.end - t.start)))
}

// checks to see if a .string token is equal to str
pub fn (t &Token) eq(js []byte, str string) bool {
	if t.kind != .string || str.len != t.end - t.start {
		return false
	}
	return C.strncmp(js.data + t.start, str.str, t.end - t.start) == 0
}

// JSON parser. Contains an array of token blocks available. Also stores
// the string being parsed now and current position in that string.
struct Parser {
	strict bool			// strict or non-strict parsing
pub mut:
	tokens []Token		// array of tokens found while parsing
mut:
	pos u32				// offset in the JSON string
	toknext u32			// next token to allocate
	toksuper int = -1	// superior token node, e.g. parent object or array
}

pub fn parser(strict bool) Parser {
	return Parser{
		strict: strict
		tokens: make(0, 25, sizeof(Token))
	}
}

pub fn (p &Parser) free() {
	unsafe { p.tokens.free() }
}

// Parse JSON string and fills Parser.tokens with all the tokens found
pub fn (p mut Parser) parse(js []byte) Error {
	p.tokens.clear()
	mut count := 0

	for ; p.pos < js.len && js[p.pos] != `\0`; p.pos++ {
		mut kind := Kind.undefined
		c := js[p.pos]
		match c {
			`{`, `[` {
				count++
				mut token := Token{}

				if p.toksuper != -1 {
					mut t := &p.tokens[p.toksuper]
					if p.strict {
						// In strict mode an object or array can't become a key
						if t.kind == .object {
							return .invalid_char
						}
					}

					t.size++
					token.parent = p.toksuper
				}
				token.kind = if c == `{` { Kind.object } else { Kind.array }
				token.start = int(p.pos)

				p.tokens << token
				p.toknext++
				p.toksuper = int(p.toknext) - 1
			}
			`}`, `]` {
				kind = if c == `}` { Kind.object } else { Kind.array }

				if p.toknext < 1 {
					return .invalid_char
				}

				mut token := &p.tokens[p.toknext - 1]
				for {
					if token.start != -1 && token.end == -1 {
						if token.kind != kind {
							return .invalid_char
						}
						token.end = int(p.pos) + 1
						p.toksuper = token.parent
						break
					}


					if token.parent == -1 {
						if token.kind != kind || p.toksuper == -1 {
							return .invalid_char
						}
						break
					}
					token = &p.tokens[token.parent]
				}
			}
			`"` {
				r := p.parse_string(js)
				if r != .no_error {
					return r
				}
				count++
				if p.toksuper != -1 {
					p.tokens[p.toksuper].size++
				}
			}
			`\t`, `\r`, ` ` {}
			`\n` {
				// if we are not strict and we hit an EOL we do exactly as we would with a ',' because commas are optional
				if !p.strict {
					if p.toksuper != -1 && p.tokens[p.toksuper].kind != .array && p.tokens[p.toksuper].kind != .object {
						p.toksuper = p.tokens[p.toksuper].parent
					}
				}
			}
			`:` {
				p.toksuper = int(p.toknext) - 1
			}
			`,` {
				if p.toksuper != -1 && p.tokens[p.toksuper].kind != .array && p.tokens[p.toksuper].kind != .object {
					p.toksuper = p.tokens[p.toksuper].parent
				}
			}
			`-`, `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `t`, `f`, `n` {
				// In strict mode primitives are: numbers and booleans
				// And they must not be keys of the object
				if p.strict {
					if p.toksuper != -1 {
						t := &p.tokens[p.toksuper]

						if t.kind == .object || (t.kind == .string && t.size != 0) {
							return .invalid_char
						}
					}
				}

				r := p.parse_primitive(js)
				if r != .no_error {
					return r
				}
				count++
				if p.toksuper != -1 {
					mut tmp := &p.tokens[p.toksuper]
					tmp.size++
				}
			}
			else {
				// In non-strict mode every unquoted value is a primitive
				if !p.strict {
					r := p.parse_primitive(js)
					if r != .no_error {
						return r
					}
					count++
					if p.toksuper != -1 {
						mut tmp := &p.tokens[p.toksuper]
						tmp.size++
					}
				} else {
					// Unexpected char in strict mode
					return .invalid_char
				}
			}
		} // end match
	} // end for

	return .no_error
}

// Fills next available token with JSON primitive.
fn (p mut Parser) parse_primitive(js []byte) Error {
	start := p.pos

	for ; p.pos < js.len && js[p.pos] != `\0`; p.pos++ {
		// In strict mode primitive must be followed by "," or "}" or "]". ":" is not be allowed
		if !p.strict {
			match js[p.pos] {
				`:`, `\t`, `\n`, ` `, `,`, `]`, `}` { goto found }
				else {}
			}
		} else {
			match js[p.pos] {
				`\t`, `\n`, ` `, `,`, `]`, `}` { goto found }
				else {}
			}
		}
	}

	if js[p.pos] < 32 || js[p.pos] >= 127 {
		p.pos = start
		return .invalid_char
	}

	if p.strict {
		// In strict mode primitive must be followed by a comma/object/array
		p.pos = start
		return .partial_packet
	}

	found:
	kind := match js[start] {
		`-`, `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9` {
			Kind.number
		}
		`t`, `f` { Kind.bool }
		else { .null }
	}

	p.tokens << Token{
		kind: kind
		start: int(start)
		end: int(p.pos)
		parent: p.toksuper
	}
	p.toknext++
	p.pos--

	return .no_error
}

// Fills next token with JSON string
fn (p mut Parser) parse_string(js []byte) Error {
	start := p.pos
	p.pos++

	// Skip starting quote
	for ; p.pos < js.len && js[p.pos] != `\0`; p.pos++ {
		c := js[p.pos]

		// Quote: end of string
		if c == `"` {
			p.tokens << Token{
				kind: .string
				start: int(start + 1)
				end: int(p.pos)
				parent: p.toksuper
			}
			p.toknext++
			return .no_error
		}

		// Backslash: Quoted symbol expected
		if c == `/` && p.pos + 1 < js.len {
			mut i := 0
			p.pos++

			match js[p.pos] {
				// allowed escaped symbols
				`"`, `/`, `\\`, `b`, `f`, `n`,`t` { break }
				// allows escaped symbol \uXXXX
				`u` {
					p.pos++
					for i = 0; i < 4 && p.pos < js.len && js[p.pos] != `\0`; i++ {
						// If it isn't a hex character we have an error
						if (js[p.pos] >= 48 && js[p.pos] <= 57) ||
							(js[p.pos] >= 65 && js[p.pos] <= 70) ||
							(js[p.pos] >= 97 && js[p.pos] <= 102) {
								p.pos = start
								return .invalid_char
						}
						p.pos++
					}
					p.pos--
				} else {
					// Unexpected symbol
					p.pos = start
					return .invalid_char
				}
			} // end match
		} // end if
	} // end for

	p.pos = start
	return .partial_packet
}
