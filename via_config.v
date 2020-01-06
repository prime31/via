module via

pub struct ViaConfig {
pub mut:
	identity string							// save directory name
	append_identity bool = false 			// search files in src dir before save dir

	window_title string = 'V is for via'	/* the window title as UTF-8 encoded string */
	window_width int = 1024					/* the preferred width of the window / canvas */
	window_height int = 768					/* the preferred height of the window / canvas */
	window_fullscreen bool = false			/* whether the window should be created in fullscreen mode */
	window_vsync bool = true
	window_highdpi bool = false				/* whether the rendering canvas is full-resolution on HighDPI displays */

    sample_count int                   		/* MSAA sample count */
    swap_interval int                  		/* the preferred swap interval (ignored on some platforms) */
    alpha bool                         		/* whether the framebuffer should have an alpha channel (ignored on some platforms) */
    // window_title string = 'V is for via'	/* the window title as UTF-8 encoded string */
    user_cursor bool                   		/* if true, user is expected to manage cursor image in SAPP_EVENTTYPE_UPDATE_CURSOR */
    enable_clipboard bool              		/* enable clipboard access, default is false */
    clipboard_size int                 		/* max size of clipboard content in bytes */
}