module c

pub enum MessageBoxFlags {
	error = 16
	warning = 32
	information = 64
}

pub enum MessageBoxButtonFlags {
	returnkey_default = 1
	escapekey_default = 2
}

pub enum MessageBoxColorType {
	background
	text
	button_border
	button_background
	button_selected
	max
}

pub struct C.SDL_MessageBoxButtonData {
pub:
	flags u32
	buttonid int
	text byteptr
}

pub struct C.SDL_MessageBoxColor {
pub:
	r byte
	g byte
	b byte
}

pub struct C.SDL_MessageBoxColorScheme {
pub:
	colors [5]SDL_MessageBoxColor
}

pub struct C.SDL_MessageBoxData {
pub:
	flags u32
	window &SDL_Window
	title byteptr
	message byteptr
	numbuttons int
	buttons &SDL_MessageBoxButtonData
	colorScheme &SDL_MessageBoxColorScheme
}

fn C.SDL_ShowMessageBox(messageboxdata &SDL_MessageBoxData, buttonid &int) int
fn C.SDL_ShowSimpleMessageBox(flags u32, title byteptr, message byteptr, window &SDL_Window) int