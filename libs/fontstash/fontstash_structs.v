module fontstash

pub enum FonsFlags {
	top_left = 1
	bottom_left = 2
}

pub enum FonsAlign {
	// Horizontal align
	left 		= 1	// Default
	center 		= 2
	right 		= 4
	// Vertical align
	top 		= 8
	middle		= 16
	bottom		= 32
	baseline	= 64 // Default
	// Combos
	left_middle = 17
	center_middle = 18
	right_middle = 20
}

pub enum FonsErrorCode {
	// Font atlas is full.
	atlas_full = 1
	// Scratch memory used to render glyphs is full, requested size reported in 'val', you may need to bump up FONS_SCRATCH_BUF_SIZE.
	scratch_full = 2
	// Calls to fonsPushState has created too large stack, if you need deep state stack bump up FONS_MAX_STATES.
	states_overflow = 3
	// Trying to pop too many states fonsPopState().
	states_underflow = 4
}

pub struct C.FONSparams {
	width int
	height int
	flags char
	userPtr voidptr
	renderCreate fn(uptr voidptr, width int, height int) int
	renderResize fn(uptr voidptr, width int, height int) int
	renderUpdate fn(uptr voidptr, rect &int, data byteptr)
	renderDraw fn(uptr voidptr, verts &f32, tcoords &f32, colors &u32, nverts int)
	renderDelete fn(uptr voidptr)
}

pub struct C.FONSquad {
pub:
	x0 f32
	y0 f32
	s0 f32
	t0 f32
	x1 f32
	y1 f32
	s1 f32
	t1 f32
}
pub fn (q C.FONSquad) str() string {
	return 'xy0: ($q.x0, $q.y0) xy1: ($q.x1, $q.y1) st0: ($q.s0, $q.t0) st1: ($q.s1, $q.t1)'
}

pub struct C.FONStextIter {
pub:
	x f32
	y f32
	nextx f32
	nexty f32
	scale f32
	spacing f32
	color u32
	codepoint u32
	isize i16
	iblur i16
	font &FONSfont
	prevGlyphIndex int
	str byteptr
	next byteptr
	end byteptr
	utf8state u32
}

pub struct C.FONSfont {}

pub struct C.FONScontext {
pub:
	params C.FONSparams
	itw f32
	ith f32
	texData byteptr
}