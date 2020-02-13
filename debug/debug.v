module debug

//#region Logging

pub fn info(msg string) {
	print('\x1b[100m \x1b[49m ')
	println(msg)
}

pub fn log(msg string) {
	print('\x1b[42m \x1b[49m ')
	println(msg)
}

pub fn warn(msg string) {
	print('\x1b[43m \x1b[49m ')
	println(msg)
}

pub fn error(msg string) {
	print('\x1b[41m \x1b[49m ')
	println(msg)
}

//#endregion