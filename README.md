# KickAssembler C64 Project (Simplified)

This project compiles Commodore 64 programs using the pre-built `amarcinkowski/super64setup` Docker image.

## How to build locally

No `docker build` needed! Just run the compilation command:

```bash
docker run --rm -v "$(pwd)":/src amarcinkowski/super64setup kickass src/main.asm -o out/main.prg
```
