# Sokol SDL Metal Util

Helper functions for using SDL2 with Sokol.

## Usage
- after creating an SDL window call `metal_util.init_metal(window)`. This will take care of setting up the window for metal rendering.
- call `sg_setup` passing the `mtl_device`, `mtl_renderpass_descriptor_cb` and `mtl_drawable_cb` as below:

```c
sg_setup(&sg_desc {
    mtl_device: metal_util.get_metal_device()
    mtl_renderpass_descriptor_cb: C.mu_get_render_pass_descriptor
    mtl_drawable_cb: C.mu_get_drawable
})
```

- when calling `sg_begin_default_pass`, pass in `metal_util.width()` and `metal_util.height()`