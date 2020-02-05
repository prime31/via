module c

pub const (
	used_import = 1
)

#flag linux  `sdl2-config --cflags --libs`
#flag darwin `sdl2-config --cflags --libs`

#flag windows -I/msys64/mingw64/include/SDL2
#flag windows -Dmain=SDL_main
#flag windows -L/mingw64/lib -lmingw32 -lSDL2main -lSDL2

#flag -DSDL_DISABLE_IMMINTRIN_H

#include <SDL.h>