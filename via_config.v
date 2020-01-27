module via
import via.libs.sokol.gfx

pub struct ViaConfig {
pub mut:
	identity string							// save directory name
	append_identity bool = false 			// search files in src dir before save dir

	window_title string = 'V is for via'	/* the window title as UTF-8 encoded string */
	window_width int = 1024					/* the preferred width of the window / canvas */
	window_height int = 768					/* the preferred height of the window / canvas */
	window_resizable bool = true			/* whether the window should be allowed to be resized */
	window_fullscreen bool = false			/* whether the window should be created in fullscreen mode */
	window_vsync bool = true
	window_highdpi bool = true				/* whether the rendering canvas is full-resolution on HighDPI displays */

	imgui bool = false				/* whether imgui should be enabled */
	imgui_gfx_debug bool = false	/* whether the Sokol gfx debugger should be enabled */
	imgui_viewports bool = true		/* whether imgui viewports should be enabled */
	imgui_docking bool = true		/* whether imgui docking should be enabled */
}