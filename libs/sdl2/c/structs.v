module c

pub struct C.SDL_Point {
pub:
	x int
	y int
}

pub struct C.SDL_RWops {}

pub struct C.SDL_Color {
pub mut:
	r byte
	g byte
	b byte
	a byte
}

pub struct C.SDL_Rect {
pub mut:
	x int
	y int
	w int
	h int
}

pub struct C.SDL_FRect
{
pub mut:
	x f32
	y f32
	w f32
	h f32
}

pub struct C.SDL_Renderer {}

pub struct C.SDL_Texture {}

pub struct C.SDL_Surface {
pub:
	flags u32
	format voidptr
	w int
	h int
	pitch int
	pixels voidptr
	userdata voidptr
	locked int
	lock_data voidptr
	clip_rect C.SDL_Rect
	map voidptr
	refcount int
}

pub struct C.SDL_AudioSpec {
pub mut:
        freq int                           /**< DSP frequency -- samples per second */
        format u16                         /**< Audio data format */
        channels byte                      /**< Number of channels: 1 mono, 2 stereo */
        silence byte                       /**< Audio buffer silence value (calculated) */
        samples u16                        /**< Audio buffer size in samples (power of 2) */
        size u32                           /**< Necessary for some compile environments */
        callback voidptr
        userdata voidptr
}
