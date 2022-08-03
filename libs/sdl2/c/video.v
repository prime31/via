module c

pub enum WindowFlags {
	fullscreen = 1
	opengl = 2
	shown = 4
	hidden = 8
	borderless = 16
	resizable = 32
	minimized = 64
	maximized = 128
	input_grabbed = 256
	input_focus = 512
	mouse_focus = 1024
	fullscreen_desktop = 4097
	foreign = 2048
	allow_highdpi = 8192
	mouse_capture = 16384
	always_on_top = 32768
	skip_taskbar = 65536
	utility = 131072
	tooltip = 262144
	popup_menu = 524288
	vulkan = 268435456
}

pub enum WindowEventId {
	non
	shown
	hidden
	exposed
	moved
	resized
	size_changed
	minimized
	maximized
	restored
	enter
	leave
	focus_gained
	focus_lost
	close
	take_focus
	hit_test
}

pub enum DisplayEventId {
	non
	orientation
}

pub enum DisplayOrientation {
	unknown
	landscape
	landscape_flipped
	portrait
	portrait_flipped
}

pub enum GLattr {
	red_size
	green_size
	blue_size
	alpha_size
	buffer_size
	doublebuffer
	depth_size
	stencil_size
	accum_red_size
	accum_green_size
	accum_blue_size
	accum_alpha_size
	stereo
	multisamplebuffers
	multisamplesamples
	accelerated_visual
	retained_backing
	context_major_version
	context_minor_version
	context_egl
	context_flags
	context_profile_mask
	share_with_current_context
	framebuffer_srgb_capable
	context_release_behavior
	context_reset_notification
	context_no_error
}

pub enum GLprofile {
	core = 1
	compatibility = 2
	es = 4
}

pub enum GLcontextFlag {
	debug_flag = 1
	forward_compatible_flag = 2
	robust_access_flag = 4
	reset_isolation_flag = 8
}

pub enum GLcontextReleaseFlag {
	non = 0
	flush = 1
}

pub enum GlContextResetNotification {
	no_notification = 0
	lose_context = 1
}

pub enum HitTestResult {
	normal
	draggable
	resize_topleft
	resize_top
	resize_topright
	resize_right
	resize_bottomright
	resize_bottom
	resize_bottomleft
	resize_left
}

pub struct C.SDL_DisplayMode {
pub:
	format u32
	w int
	h int
	refresh_rate int
	driverdata voidptr
}

pub struct C.SDL_Window {}

fn C.SDL_GetNumVideoDrivers() int
fn C.SDL_GetVideoDriver(index int) byteptr
fn C.SDL_VideoInit(driver_name byteptr) int
fn C.SDL_VideoQuit()
fn C.SDL_GetCurrentVideoDriver() byteptr
fn C.SDL_GetNumVideoDisplays() int
fn C.SDL_GetDisplayName(displayIndex int) byteptr
fn C.SDL_GetDisplayBounds(displayIndex int, rect &C.SDL_Rect) int
fn C.SDL_GetDisplayUsableBounds(displayIndex int, rect &C.SDL_Rect) int
fn C.SDL_GetDisplayDPI(displayIndex int, ddpi &f32, hdpi &f32, vdpi &f32) int
fn C.SDL_GetDisplayOrientation(displayIndex int) DisplayOrientation
fn C.SDL_GetNumDisplayModes(displayIndex int) int
fn C.SDL_GetDisplayMode(displayIndex int, modeIndex int, mode &C.SDL_DisplayMode) int
fn C.SDL_GetDesktopDisplayMode(displayIndex int, mode &C.SDL_DisplayMode) int
fn C.SDL_GetCurrentDisplayMode(displayIndex int, mode &C.SDL_DisplayMode) int
fn C.SDL_GetClosestDisplayMode(displayIndex int, mode &C.SDL_DisplayMode, closest &C.SDL_DisplayMode) &C.SDL_DisplayMode
fn C.SDL_GetWindowDisplayIndex(window &C.SDL_Window) int
fn C.SDL_SetWindowDisplayMode(window &C.SDL_Window, mode &C.SDL_DisplayMode) int
fn C.SDL_GetWindowDisplayMode(window &C.SDL_Window, mode &C.SDL_DisplayMode) int
fn C.SDL_GetWindowPixelFormat(window &C.SDL_Window) u32
fn C.SDL_CreateWindow(title byteptr, x int, y int, w int, h int, flags u32) &C.SDL_Window
fn C.SDL_CreateWindowFrom(data voidptr) &C.SDL_Window
fn C.SDL_GetWindowID(window &C.SDL_Window) u32
fn C.SDL_GetWindowFromID(id u32) &C.SDL_Window
fn C.SDL_GetWindowFlags(window &C.SDL_Window) u32
fn C.SDL_SetWindowTitle(window &C.SDL_Window, title byteptr)
fn C.SDL_GetWindowTitle(window &C.SDL_Window) byteptr
fn C.SDL_SetWindowIcon(window &C.SDL_Window, icon &C.SDL_Surface)
fn C.SDL_SetWindowData(window &C.SDL_Window, name byteptr, userdata voidptr) voidptr
fn C.SDL_GetWindowData(window &C.SDL_Window, name byteptr) voidptr
fn C.SDL_SetWindowPosition(window &C.SDL_Window, x int, y int)
fn C.SDL_GetWindowPosition(window &C.SDL_Window, x &int, y &int)
fn C.SDL_SetWindowSize(window &C.SDL_Window, w int, h int)
fn C.SDL_GetWindowSize(window &C.SDL_Window, w &int, h &int)
fn C.SDL_GetWindowBordersSize(window &C.SDL_Window, top &int, left &int, bottom &int, right &int) int
fn C.SDL_SetWindowMinimumSize(window &C.SDL_Window, min_w int, min_h int)
fn C.SDL_GetWindowMinimumSize(window &C.SDL_Window, w &int, h &int)
fn C.SDL_SetWindowMaximumSize(window &C.SDL_Window, max_w int, max_h int)
fn C.SDL_GetWindowMaximumSize(window &C.SDL_Window, w &int, h &int)
fn C.SDL_SetWindowBordered(window &C.SDL_Window, bordered Bool)
fn C.SDL_SetWindowResizable(window &C.SDL_Window, resizable Bool)
fn C.SDL_ShowWindow(window &C.SDL_Window)
fn C.SDL_HideWindow(window &C.SDL_Window)
fn C.SDL_RaiseWindow(window &C.SDL_Window)
fn C.SDL_MaximizeWindow(window &C.SDL_Window)
fn C.SDL_MinimizeWindow(window &C.SDL_Window)
fn C.SDL_RestoreWindow(window &C.SDL_Window)
fn C.SDL_SetWindowFullscreen(window &C.SDL_Window, flags u32) int
fn C.SDL_GetWindowSurface(window &C.SDL_Window) &C.SDL_Surface
fn C.SDL_UpdateWindowSurface(window &C.SDL_Window) int
fn C.SDL_UpdateWindowSurfaceRects(window &C.SDL_Window, rects &C.SDL_Rect, numrects int) int
fn C.SDL_SetWindowGrab(window &C.SDL_Window, grabbed Bool)
fn C.SDL_GetWindowGrab(window &C.SDL_Window) Bool
fn C.SDL_GetGrabbedWindow() &C.SDL_Window
fn C.SDL_SetWindowBrightness(window &C.SDL_Window, brightness f32) int
fn C.SDL_GetWindowBrightness(window &C.SDL_Window) f32
fn C.SDL_SetWindowOpacity(window &C.SDL_Window, opacity f32) int
fn C.SDL_GetWindowOpacity(window &C.SDL_Window, out_opacity &f32) int
fn C.SDL_SetWindowModalFor(modal_window &C.SDL_Window, parent_window &C.SDL_Window) int
fn C.SDL_SetWindowInputFocus(window &C.SDL_Window) int
fn C.SDL_SetWindowGammaRamp(window &C.SDL_Window, red &u16, green &u16, blue &u16) int
fn C.SDL_GetWindowGammaRamp(window &C.SDL_Window, red &u16, green &u16, blue &u16) int
fn C.SDL_SetWindowHitTest(window &C.SDL_Window, callback fn(&C.SDL_Window, &C.SDL_Point, voidptr) HitTestResult, callback_data voidptr) int
fn C.SDL_DestroyWindow(window &C.SDL_Window)
fn C.SDL_IsScreenSaverEnabled() Bool
fn C.SDL_EnableScreenSaver()
fn C.SDL_DisableScreenSaver()
fn C.SDL_GL_LoadLibrary(path byteptr) int
fn C.SDL_GL_GetProcAddress(proc byteptr) voidptr
fn C.SDL_GL_UnloadLibrary()
fn C.SDL_GL_ExtensionSupported(extension byteptr) Bool
fn C.SDL_GL_ResetAttributes()
fn C.SDL_GL_SetAttribute(attr GLattr, value int) int
fn C.SDL_GL_GetAttribute(attr GLattr, value &int) int
fn C.SDL_GL_CreateContext(window &C.SDL_Window) voidptr
fn C.SDL_GL_MakeCurrent(window &C.SDL_Window, context voidptr) int
fn C.SDL_GL_GetCurrentWindow() &C.SDL_Window
fn C.SDL_GL_GetCurrentContext() voidptr
fn C.SDL_GL_GetDrawableSize(window &C.SDL_Window, w &int, h &int)
fn C.SDL_GL_SetSwapInterval(interval int) int
fn C.SDL_GL_GetSwapInterval() int
fn C.SDL_GL_SwapWindow(window &C.SDL_Window)
fn C.SDL_GL_DeleteContext(context voidptr)