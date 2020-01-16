module via
import via.libs.imgui

pub fn imgui_init(win voidptr, gl_context voidptr, viewports, docking bool) {
	igCreateContext(C.NULL)

	mut io := imgui.get_io()
	io.ConfigFlags |= C.ImGuiConfigFlags_NavEnableKeyboard
	if docking { io.ConfigFlags |= C.ImGuiConfigFlags_DockingEnable }
	if viewports { io.ConfigFlags |= C.ImGuiConfigFlags_ViewportsEnable }

	if (io.ConfigFlags & C.ImGuiConfigFlags_ViewportsEnable) != 0 {
		mut style := igGetStyle()
		style.WindowRounding = 0
	}

	imgui.init_for_gl('#version 150'.str, win, gl_context)
}

fn imgui_new_frame(win voidptr) {
	imgui.new_frame(win)
}

fn imgui_render(win voidptr, gl_context voidptr) {
	igRender()

	io := imgui.get_io()
	sg_apply_viewport(0, 0, int(io.DisplaySize.x), int(io.DisplaySize.y), false)
	ImGui_ImplOpenGL3_RenderDrawData(C.igGetDrawData())

	if (io.ConfigFlags & C.ImGuiConfigFlags_ViewportsEnable) != 0 {
		igUpdatePlatformWindows()
		igRenderPlatformWindowsDefault(C.NULL, C.NULL)
		SDL_GL_MakeCurrent(win, gl_context)
	}
}

fn imgui_shutdown() {
	imgui.shutdown()
}