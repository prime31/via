module sdl2
import via.libs.sdl2.c

pub struct C.SDL_Keysym {
pub:
	scancode Scancode	/**< SDL physical key code - see ::SDL_Scancode for details */
	sym int				/**< SDL virtual key code - see ::SDL_Keycode for details */
	mod u16				/**< current key modifiers */
	unused u32			/**< \deprecated use SDL_TextInputEvent instead */
}

pub enum Keymod {
	non = 0
	lshift = 1
	rshift = 2
	lctrl = 64
	rctrl = 128
	lalt = 256
	ralt = 512
	lgui = 1024
	rgui = 2048
	num = 4096
	caps = 8192
	mode = 16384
	reserved = 32768
}

fn C.SDL_GetKeyboardFocus() &SDL_Window
fn C.SDL_GetKeyboardState(numkeys &int) &byte
fn C.SDL_GetModState() Keymod
fn C.SDL_SetModState(modstate Keymod)
fn C.SDL_GetKeyFromScancode(scancode Scancode) int
fn C.SDL_GetScancodeFromKey(key int) Scancode
fn C.SDL_GetScancodeName(scancode Scancode) byteptr
fn C.SDL_GetScancodeFromName(name byteptr) Scancode
fn C.SDL_GetKeyName(key int) byteptr
fn C.SDL_GetKeyFromName(name byteptr) int
fn C.SDL_StartTextInput()
fn C.SDL_IsTextInputActive() c.Bool
fn C.SDL_StopTextInput()
fn C.SDL_SetTextInputRect(rect &SDL_Rect)
fn C.SDL_HasScreenKeyboardSupport() c.Bool
fn C.SDL_IsScreenKeyboardShown(window &SDL_Window) c.Bool