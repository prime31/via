module simgui

pub struct C.simgui_desc_t {
pub mut:
    max_vertices int
    color_format C.sg_pixel_format
    depth_format C.sg_pixel_format
    sample_count int
    dpi_scale f32
    ini_filename byteptr
    no_default_font bool
    disable_hotkeys bool   /* don't let ImGui handle Ctrl-A,C,V,X,Y,Z */
}

fn C.simgui_setup(desc &C.simgui_desc_t)
fn C.simgui_new_frame(width int, height int, delta_time f64)
fn C.simgui_render()
// remove if not using Sokol app and ensure SOKOL_IMGUI_NO_SOKOL_APP is defined
fn C.simgui_handle_event(ev &C.sapp_event) bool
fn C.simgui_shutdown()