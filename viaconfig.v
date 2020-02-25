module via
import via.window
import via.graphics
import via.libs.sokol.gfx

pub struct ViaConfig {
pub mut:
	identity string						// save directory name
	append_identity bool = false 		// search files in src dir before save dir

	resolution_policy graphics.ResolutionPolicy	// defines how the main render texture should be blitted to the backbuffer
	design_width int = 1024				// the width of the main offscreen render texture when the policy is not .default
	design_height int = 768				// the height of the main offscreen render texture when the policy is not .default

	max_quads int = 5000				// max number of quads allowed to be rendered per frame (sprites and text)
	max_tris int = 500					// max number of triangles allowed to be rendered per frame (shapes and lines)
	min_filter gfx.Filter = gfx.Filter.nearest	// min filter used for all textures created, modifiable via graphics.set_default_filter
	mag_filter gfx.Filter = .nearest			// mag filter used for all textures created

	win_title string = 'V is for via'	// the window title as UTF-8 encoded string
	win_width int = 1024				// the preferred width of the window / canvas
	win_height int = 768				// the preferred height of the window / canvas
	win_resizable bool = true			// whether the window should be allowed to be resized
	win_fullscreen bool = false			// whether the window should be created in fullscreen mode
	win_vsync bool = true
	win_highdpi bool = false			// whether the backbuffer is full-resolution on HighDPI displays

	imgui bool = false					// whether imgui should be enabled
	imgui_gfx_debug bool = false		// whether the Sokol gfx debugger should be enabled. Requires imgui.
	imgui_viewports bool = true			// whether imgui viewports should be enabled
	imgui_docking bool = true			// whether imgui docking should be enabled
}

fn (vc &ViaConfig) window_config() window.WindowConfig {
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

fn (vc &ViaConfig) graphics_config() graphics.GraphicsConfig {
	return graphics.GraphicsConfig{
		resolution_policy: vc.resolution_policy
		design_width: vc.design_width
		design_height: vc.design_height
		max_quads: vc.max_quads
		max_tris: vc.max_tris
		min_filter: vc.min_filter
		mag_filter: vc.mag_filter
	}
}