module via
import via.libs.imgui
import via.libs.sokol.gfx_imgui

const (
	sg_imgui = &C.sg_imgui_t{}
)

fn imgui_init(win voidptr, gl_context voidptr, viewports, docking, gfx_dbg bool) {
	if gfx_dbg { gfx_imgui.initialize(sg_imgui) }
	C.igCreateContext(C.NULL)

	mut io := C.igGetIO()
	io.ConfigFlags |= C.ImGuiConfigFlags_NavEnableKeyboard
	if docking { io.ConfigFlags |= C.ImGuiConfigFlags_DockingEnable }
	if viewports { io.ConfigFlags |= C.ImGuiConfigFlags_ViewportsEnable }

	if (io.ConfigFlags & C.ImGuiConfigFlags_ViewportsEnable) != 0 {
		mut style := C.igGetStyle()
		style.WindowRounding = 0
	}

	imgui.init_for_gl('#version 150'.str, win, gl_context)
}

// returns true if the event is handled by imgui and should be ignored by via
fn imgui_handle_event(evt &C.SDL_Event) bool {
	if C.ImGui_ImplSDL2_ProcessEvent(evt) {
		match evt.@type {
			.mousewheel, .mousebuttondown { return C.igGetIO().WantCaptureMouse }
			.textinput, .keydown, .keyup { return C.igGetIO().WantCaptureKeyboard }
			.windowevent { return true }
			else { return false }
		}
	}
	return false
}

fn imgui_new_frame(win voidptr, gfx_dbg bool) {
	imgui.new_frame(win)

	if gfx_dbg {
		gfx_imgui.draw_menu(sg_imgui)
		gfx_imgui.draw(sg_imgui)
	}
}

fn imgui_render(win voidptr, gl_context voidptr) {
	C.igRender()

	io := C.igGetIO()
	C.sg_apply_viewport(0, 0, int(io.DisplaySize.x), int(io.DisplaySize.y), false)
	C.ImGui_ImplOpenGL3_RenderDrawData(C.igGetDrawData())

	if (io.ConfigFlags & C.ImGuiConfigFlags_ViewportsEnable) != 0 {
		C.igUpdatePlatformWindows()
		C.igRenderPlatformWindowsDefault(C.NULL, C.NULL)
		C.SDL_GL_MakeCurrent(win, gl_context)
	}
}

fn imgui_shutdown() {
	imgui.shutdown()
}