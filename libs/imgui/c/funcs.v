module c

fn C.igCheckbox(label voidptr, p_open voidptr)
fn C.igGetIO() voidptr
fn C.igCreateContext(shared_font_atlas voidptr) voidptr
fn C.igDestroyContext(igui_context voidptr)
fn C.igSetCurrentContext(igui_context voidptr)
fn C.igStyleColorsDark(dst voidptr)
fn C.igNewFrame()
fn C.igShowDemoWindow(p_open voidptr)
fn C.igBegin(name byteptr, p_open voidptr, flags int) bool
fn C.igText(fmt byteptr, ...)
fn C.igSliderFloat(label byteptr, v voidptr, v_min f32, v_max f32, format byteptr, power f32) bool
fn C.igColorEdit3(label byteptr, col voidptr, flags int) bool
fn C.igButton(label byteptr, size C.ImVec2) bool
fn C.igSameLine(offset_from_start_x f32, spacing f32)
fn C.igEnd()
fn C.igRender()
fn C.igGetDrawData() voidptr
fn C.igGetStyle() &C.ImGuiStyle

fn C.igBeginMainMenuBar() bool
fn C.igBeginMenu(label byteptr, show bool) bool
fn C.igMenuItemBoolPtr(label byteptr, unknown byteptr, open &bool, something bool)
fn C.igEndMenu()
fn C.igEndMainMenuBar()

// multiple viewport
fn C.igUpdatePlatformWindows()
fn C.igRenderPlatformWindowsDefault(voidptr, voidptr)

// ImGui SDL2 and OpenGL3 implementation
fn C.ImGui_ImplSDL2_InitForOpenGL(window voidptr, sdl_gl_context voidptr) bool
fn C.ImGui_ImplSDL2_ProcessEvent(event voidptr) bool
fn C.ImGui_ImplSDL2_NewFrame(window voidptr)
fn C.ImGui_ImplSDL2_Shutdown()

fn C.ImGui_ImplOpenGL3_Init(glsl_version byteptr) bool
fn C.ImGui_ImplOpenGL3_NewFrame()
fn C.ImGui_ImplOpenGL3_RenderDrawData(draw_data voidptr)
fn C.ImGui_ImplOpenGL3_Shutdown()