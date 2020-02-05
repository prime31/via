module imgui
import via.libs.imgui.c

pub const ( used_import = c.used_import )

// ImGui SDL2 and OpenGL3 implementation
fn C.ImGui_ImplSDL2_InitForOpenGL(window voidptr, sdl_gl_context voidptr) bool
fn C.ImGui_ImplSDL2_ProcessEvent(event voidptr) bool
fn C.ImGui_ImplSDL2_NewFrame(window voidptr)
fn C.ImGui_ImplSDL2_Shutdown()

fn C.ImGui_ImplOpenGL3_Init(glsl_version byteptr) bool
fn C.ImGui_ImplOpenGL3_NewFrame()
fn C.ImGui_ImplOpenGL3_RenderDrawData(draw_data voidptr)
fn C.ImGui_ImplOpenGL3_Shutdown()


// ImGui lifecycle helpers, wrapping ImGui, SDL2 Impl and GL Impl methods
// BEFORE calling init_for_gl a gl loader lib must be called! You must use the same one
// used in the makefile when imgui was compiled!
pub fn init_for_gl(glsl_version byteptr, window voidptr, gl_context voidptr) {
	C.igCreateContext(C.NULL)
	C.ImGui_ImplSDL2_InitForOpenGL(window, gl_context)
	C.ImGui_ImplOpenGL3_Init(glsl_version)
}

pub fn new_frame(window voidptr) {
	C.ImGui_ImplOpenGL3_NewFrame()
	C.ImGui_ImplSDL2_NewFrame(window)
	C.igNewFrame()
}

pub fn shutdown() {
    C.ImGui_ImplOpenGL3_Shutdown()
    C.ImGui_ImplSDL2_Shutdown()
    C.igDestroyContext(C.NULL)
}
