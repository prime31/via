# FMOD
FMOD V module


# Installation macOS
- Download FMOD
- Extract the dmg and put the extracted "FMOD Programmers API" folder in the prime31/fmod folder
- Run `make` in that folder to have the headers and dylibs copied into the correct folder

# Installation Linux
- Download FMOD
- Extract the archive and put the extracted "fmodstudioapi" folder in the prime31/fmod folder (make sure it has this exact name!)
- Run `make` in that folder to have the headers and libs copied into the correct folder


# Module Structure

- **fmod Module**: C header and binary includes
    - **core Module**: all FMOD Core methods
        - **internal Module**: Core C declarations
    - **studio Module**: all FMOD Studio methods
        - **internal Module**: Studio C declarations


# Usage
To access the V API you can just import the *core* module: `import prime31.fmod.core as fmod`

If you come accross something that isn't wrapped by the V API then you can just use the C methods/defines directly. The import of the *core*/*studio* module will import it's *internal* module exposing all the C declarations.