
// any pain points in dealing with some V bugs accessing C structs are made less painful via
// helper methods defined here

void gfx_hack_set_subimage(sg_image_content* content, int x, int y, sg_subimage_content subimage_content) {
    content->subimage[x][y] = subimage_content;
}

sg_image_desc* gfx_hack_make_image_desc(sg_subimage_content subimage_content) {
    return &(sg_image_desc) {
        .content.subimage[0][0] = subimage_content
    };
}