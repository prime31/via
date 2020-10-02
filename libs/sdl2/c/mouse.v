module c

pub enum SystemCursor {
	system_cursor_arrow
	system_cursor_ibeam
	system_cursor_wait
	system_cursor_crosshair
	system_cursor_waitarrow
	system_cursor_sizenwse
	system_cursor_sizenesw
	system_cursor_sizewe
	system_cursor_sizens
	system_cursor_sizeall
	system_cursor_no
	system_cursor_hand
	num_system_cursors
}

pub enum MouseWheelDirection {
	normal
	flipped
}

pub struct C.SDL_Cursor {}

fn C.SDL_GetMouseFocus() &C.SDL_Window
fn C.SDL_GetMouseState(x &int, y &int) u32
fn C.SDL_GetGlobalMouseState(x &int, y &int) u32
fn C.SDL_GetRelativeMouseState(x &int, y &int) u32
fn C.SDL_WarpMouseInWindow(window &C.SDL_Window, x int, y int)
fn C.SDL_WarpMouseGlobal(x int, y int) int
fn C.SDL_SetRelativeMouseMode(enabled Bool) int
fn C.SDL_CaptureMouse(enabled Bool) int
fn C.SDL_GetRelativeMouseMode() Bool
fn C.SDL_CreateCursor(data &byte, mask &byte, w int, h int, hot_x int, hot_y int) &C.SDL_Cursor
fn C.SDL_CreateColorCursor(surface &C.SDL_Surface, hot_x int, hot_y int) &C.SDL_Cursor
fn C.SDL_CreateSystemCursor(id SystemCursor) &C.SDL_Cursor
fn C.SDL_SetCursor(cursor &C.SDL_Cursor)
fn C.SDL_GetCursor() &C.SDL_Cursor
fn C.SDL_GetDefaultCursor() &C.SDL_Cursor
fn C.SDL_FreeCursor(cursor &C.SDL_Cursor)
fn C.SDL_ShowCursor(toggle int) int