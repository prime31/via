module gfx_imgui

#flag -DSOKOL_TRACE_HOOKS

#include "thirdparty/cimgui.h"
#define SOKOL_GFX_IMGUI_IMPL
#include "sokol_gfx_imgui.h"

[inline]
pub fn initialize(ctx &C.sg_imgui_t) {
	C.sg_imgui_init(ctx)
}

[inline]
pub fn discard(ctx &C.sg_imgui_t) {
	C.sg_imgui_discard(ctx)
}

[inline]
pub fn draw(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw(ctx)
}

[inline]
pub fn draw_buffers_content(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_buffers_content(ctx)
}

[inline]
pub fn draw_images_content(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_images_content(ctx)
}

[inline]
pub fn draw_shaders_content(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_shaders_content(ctx)
}

[inline]
pub fn draw_pipelines_content(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_pipelines_content(ctx)
}

[inline]
pub fn draw_passes_content(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_passes_content(ctx)
}

[inline]
pub fn draw_capture_content(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_capture_content(ctx)
}

[inline]
pub fn draw_capabilities_content(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_capabilities_content(ctx)
}

[inline]
pub fn draw_buffers_window(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_buffers_window(ctx)
}

[inline]
pub fn draw_images_window(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_images_window(ctx)
}

[inline]
pub fn draw_shaders_window(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_shaders_window(ctx)
}

[inline]
pub fn draw_pipelines_window(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_pipelines_window(ctx)
}

[inline]
pub fn draw_passes_window(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_passes_window(ctx)
}

[inline]
pub fn draw_capture_window(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_capture_window(ctx)
}

[inline]
pub fn draw_capabilities_window(ctx &C.sg_imgui_t) {
	C.sg_imgui_draw_capabilities_window(ctx)
}

[inline]
pub fn draw_menu(ctx &C.sg_imgui_t) {
	if C.igBeginMainMenuBar() {
		if C.igBeginMenu(c'sokol-gfx', true) {
			C.igMenuItemBoolPtr(c'Buffers', c'', &ctx.buffers.open, true)
			C.igMenuItemBoolPtr(c'Images', c'', &ctx.images.open, true)
			C.igMenuItemBoolPtr(c'Shaders', c'', &ctx.shaders.open, true)
			C.igMenuItemBoolPtr(c'Pipelines', c'', &ctx.pipelines.open, true)
			C.igMenuItemBoolPtr(c'Passes', c'', &ctx.passes.open, true)
			C.igMenuItemBoolPtr(c'Calls', c'', &ctx.capture.open, true)
			C.igEndMenu()
		}
		C.igEndMainMenuBar()
	}
}