# sdl2
SDL2 V module

Current APIs available/tested in examples :
- basic graphics (2D drawing)
- SDL2_Image support
- SDL2_TTF font (text rendering)
- input handling (keyboard/joystick events)
- sounds (WAV mixing)
- music (MOD mixing)
- more to come...

# Support
- linux (major distros)
- macOS (brew)
- windows (msys2/mingw64 only for now)


# Dependencies

## Linux
Fedora :
`$ sudo dnf install SDL2-devel SDL2_ttf-devel SDL2_mixer-devel SDL2_image-devel`

Ubuntu :
`$ sudo apt install libsdl2-ttf-dev libsdl2-mixer-dev libsdl2-image-dev`

ClearLinux :
`$ sudo swupd bundle-add devpkg-SDL2_ttf devpkg-SDL2_mixer devpkg-SDL2_image`

## MacOS
Brew :
`$ brew install sdl2 sdl2_ttf sdl2_mixer sdl2_image`

## Windows
Windows/MSYS2 :
`$ pacman -S mingw-w64-x86_64-SDL2_ttf mingw-w64-x86_64-SDL2_mixer mingw-w64-x86_64-SDL2_image`