module via
import via.window

pub struct ViaConfig {
pub mut:
	identity string						// save directory name
	append_identity bool = false 		// search files in src dir before save dir

	max_quad_count int = 5000			// max number of quads allowed to be rendered per frame (sprites and text)
	max_tri_count int = 500				// max number of triangles allowed to be rendered per frame (shapes and lines)

	win_title string = 'V is for via'	// the window title as UTF-8 encoded string
	win_width int = 1024				// the preferred width of the window / canvas
	win_height int = 768				// the preferred height of the window / canvas
	win_resizable bool = true			// whether the window should be allowed to be resized
	win_fullscreen bool = false			// whether the window should be created in fullscreen mode
	win_vsync bool = true
	win_highdpi bool = false			// whether the backbuffer is full-resolution on HighDPI displays

	imgui bool = false					// whether imgui should be enabled
	imgui_gfx_debug bool = false		// whether the Sokol gfx debugger should be enabled
	imgui_viewports bool = true			// whether imgui viewports should be enabled
	imgui_docking bool = true			// whether imgui docking should be enabled
}

fn (vc &ViaConfig) get_win_config() window.WindowConfig {
	return window.WindowConfig{
		title: vc.win_title
		width: vc.win_width
		height: vc.win_height
		resizable: vc.win_resizable
		fullscreen: vc.win_fullscreen
		vsync: vc.win_vsync
		highdpi: vc.win_highdpi
	}
}