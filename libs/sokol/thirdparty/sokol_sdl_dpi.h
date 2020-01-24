
#if defined(__APPLE__)
#import <Cocoa/Cocoa.h>
#include <TargetConditionals.h>
#import "SDL.h"

void sokol_sdl_fix_cb(void* userdata, SDL_Event* evt) {
    if (evt->type == SDL_WINDOWEVENT) {
        if (evt->window.event == SDL_WINDOWEVENT_SHOWN || evt->window.event == SDL_WINDOWEVENT_EXPOSED) {
            SDL_SetEventFilter(NULL, NULL);
            printf("macos low-dpi hack in place\n");
            [[[[[NSApp windows] objectAtIndex:0] contentView] layer] setContentsGravity:kCAGravityBottomLeft];
            [[[[[NSApp windows] objectAtIndex:0] contentView] layer] setContentsScale:1.0];
        }
    }
}

void sokol_sdl_fix_low_dpi(void) {
    SDL_SetEventFilter(sokol_sdl_fix_cb, NULL);
}

#else

void sokol_sdl_fix_low_dpi(void) {}

#endif