module jsmn
import os

const (
	test = '{"user": "johndoe", "admin": false, "uid": 1000, "groups": ["users", "wheel", "audio", "video"]}'
	non_strict = '{
		user: johndoe,
		admin: false,
		uid: 1000,
		groups: [users, wheel, audio, video]
	}'
	non_strict_no_comma = '{
		user: johndoe
		admin: false
		uid: 1000
		groups: [users, wheel, audio, video]
	}'
	non_strict_no_brace = '
	user: johndoe
	admin: false
	uid: 1000
	groups: [users, wheel, audio, video]'
)

fn test_parse_test() {
	bytes := test.bytes()
	mut p := jsmn.parser(true)
	res := p.parse(bytes)
	
	assert res == .no_error
	assert p.tokens.len == 13
}

fn test_parse_test_non_strict() {
	bytes := test.bytes()
	mut p := jsmn.parser(false)
	res := p.parse(bytes)
	
	assert res == .no_error
	assert p.tokens.len == 13
}

fn test_non_strict() {
	bytes := non_strict.bytes()
	mut p := jsmn.parser(false)
	res := p.parse(bytes)
	
	assert res == .no_error
	assert p.tokens.len == 13
}

fn test_non_strict_with_strict_on() {
	bytes := non_strict.bytes()
	mut p := jsmn.parser(true)
	res := p.parse(bytes)
	
	assert res == .invalid_char
}

fn test_non_strict_no_comma() {
	bytes := non_strict_no_comma.bytes()
	mut p := jsmn.parser(false)
	res := p.parse(bytes)
	
	assert res == .no_error
	assert p.tokens.len == 13
}

fn test_non_strict_no_comma_strict_on() {
	bytes := non_strict_no_comma.bytes()
	mut p := jsmn.parser(true)
	res := p.parse(bytes)
	
	assert res == .invalid_char
}

fn test_non_strict_no_braces() {
	bytes := non_strict_no_brace.bytes()
	mut p := jsmn.parser(false)
	res := p.parse(bytes)
	
	assert res == .no_error
	assert p.tokens.len == 12
}

fn test_parse_utils() {
	bytes := test.bytes()
	mut p := jsmn.parser(true)
	res := p.parse(bytes)
	
	assert res == .no_error
	assert p.tokens.len == 13
	
	mut tok := jsmn.object_get_member(bytes, &p.tokens[0], 'user')
	assert tok.as_str(bytes) == 'johndoe'
	
	tok = jsmn.object_get_member(bytes, &p.tokens[0], 'admin')
	assert tok.as_str(bytes) == 'false'

	tok = jsmn.object_get_member(bytes, &p.tokens[0], 'uid')
	assert tok.as_str(bytes) == '1000'
	
	arr := jsmn.object_get_member(bytes, &p.tokens[0], 'groups')
	tok = jsmn.array_get_at(arr, 0)
	assert tok.as_str(bytes) == 'users'

	tok = jsmn.array_get_at(arr, 2)
	assert tok.as_str(bytes) == 'audio'
}