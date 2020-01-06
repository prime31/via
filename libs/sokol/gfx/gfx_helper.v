module gfx

// any pain points in dealing with some V bugs accessing C structs are made less painful via
// helper methods defined here

fn C.gfx_hack_set_subimage(content &sg_image_content, x int, y int, subimage_content sg_subimage_content)
fn C.gfx_hack_make_image_desc(subimage_content C.sg_subimage_content) &C.sg_image_desc