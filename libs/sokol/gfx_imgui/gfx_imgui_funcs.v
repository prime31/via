module gfx_imgui

[typedef]
pub struct C.sg_imgui_t {
pub mut:
    init_tag u32
    buffers C.sg_imgui_buffers_t
    images C.sg_imgui_images_t
    shaders C.sg_imgui_shaders_t
    pipelines C.sg_imgui_pipelines_t
    passes C.sg_imgui_passes_t
    capture C.sg_imgui_capture_t
    caps C.sg_imgui_caps_t
    cur_pipeline C.sg_pipeline
    hooks C.sg_trace_hooks
}

struct C.sg_imgui_buffers_t {
pub mut:
    open bool
    num_slots int
    sel_buf C.sg_buffer
    slots &C.sg_imgui_buffer_t
}

struct C.sg_imgui_images_t {
pub mut:
    open bool
    num_slots int
    sel_img C.sg_image
    slots &C.sg_imgui_image_t
}

struct C.sg_imgui_shaders_t {
pub mut:
    open bool
    num_slots int
    sel_shd C.sg_shader
    slots &C.sg_imgui_shader_t
}

struct C.sg_imgui_pipelines_t {
pub mut:
    open bool
    num_slots int
    sel_pip C.sg_pipeline
    slots &C.sg_imgui_pipeline_t
}

struct C.sg_imgui_passes_t {
pub mut:
    open bool
    num_slots int
    sel_pass C.sg_pass
    slots &C.sg_imgui_pass_t
}

struct C.sg_imgui_capture_t {
pub mut:
    open bool
    bucket_index u32      /* which bucket to record to, 0 or 1 */
    sel_item u32          /* currently selected capture item by index */
    bucket [2]C.sg_imgui_capture_bucket_t
}

struct C.sg_imgui_caps_t {
pub mut:
    open bool
}

fn C.sg_imgui_init(ctx &C.sg_imgui_t)
fn C.sg_imgui_discard(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_buffers_content(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_images_content(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_shaders_content(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_pipelines_content(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_passes_content(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_capture_content(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_capabilities_content(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_buffers_window(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_images_window(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_shaders_window(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_pipelines_window(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_passes_window(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_capture_window(ctx &C.sg_imgui_t)
fn C.sg_imgui_draw_capabilities_window(ctx &C.sg_imgui_t)