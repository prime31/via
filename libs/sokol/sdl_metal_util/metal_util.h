#if defined(SOKOL_METAL)
#import <Cocoa/Cocoa.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <SDL.h>

static void* _window;
static CAMetalLayer* _metal_layer;
static id<CAMetalDrawable> _drawable;
static MTLRenderPassDescriptor* _render_pass_descriptor;
static CGSize _fb_size;
#endif

#if defined(SOKOL_METAL)
CGSize _mu_calculate_drawable_size() {
    static float content_scale = 0;
    if (content_scale < 0)
        content_scale = _metal_layer.contentsScale;

    int width, height;
    SDL_GetWindowSize(_window, &width, &height);

    return CGSizeMake(width * _metal_layer.contentsScale, height * _metal_layer.contentsScale);
}

void mu_create_metal_layer(void* window) {
    _window = window;
	SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_PRESENTVSYNC);
	_metal_layer = (__bridge __typeof__ (CAMetalLayer*))SDL_RenderGetMetalLayer(renderer);
    SDL_DestroyRenderer(renderer);

    _metal_layer.framebufferOnly = YES;
}

const void* mu_get_metal_device() {
    return (__bridge const void*)_metal_layer.device;
}

const void* mu_get_render_pass_descriptor() {
    // todo: do we need to set the drawableSize? doesnt seem like we do...
    //_metal_layer.drawableSize = _mu_calculate_drawable_size();

    _drawable = [_metal_layer nextDrawable];
    _fb_size = _metal_layer.drawableSize;

    _render_pass_descriptor = NULL;
    _render_pass_descriptor = [[MTLRenderPassDescriptor alloc] init];
    _render_pass_descriptor.colorAttachments[0].texture = _drawable.texture;

    return (__bridge const void*)_render_pass_descriptor;
}

const void* mu_get_drawable() {
    return (__bridge const void*)_drawable;
}

float mu_dpi_scale() {
    return _metal_layer.contentsScale;
}

float mu_width() {
    return _fb_size.width;
}

float mu_height() {
    return _fb_size.height;
}

void mu_set_framebuffer_only(bool framebuffer_only) {
    _metal_layer.framebufferOnly = framebuffer_only;
}

void mu_set_drawable_size(int width, int height) {
    _metal_layer.drawableSize = CGSizeMake(width, height);
}

void mu_set_display_sync_enabled(bool enabled) {
    _metal_layer.displaySyncEnabled = enabled;
}

#else

void mu_create_metal_layer(void* window) {}

const void* mu_get_metal_device() { return 0; }

const void* mu_get_render_pass_descriptor() { return 0; }

const void* mu_get_drawable() { return 0; }

void mu_set_framebuffer_only(bool framebuffer_only) {}

void mu_set_drawable_size(int width, int height) {}

void mu_set_display_sync_enabled(bool enabled) {}

#endif