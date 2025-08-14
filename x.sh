#!/bin/bash

# Nazwa głównego katalogu projektu
PROJECT_DIR="kickass-c64-project-simplified"

# Utwórz główny katalog i wejdź do niego
#mkdir -p "$PROJECT_DIR"
#cd "$PROJECT_DIR"

# Utwórz wymaganą strukturę katalogów
mkdir -p .github/workflows src out

# Utwórz plik .gitignore
cat << 'EOF' > .gitignore
# Katalog z wynikami kompilacji
out/
EOF

# Utwórz plik źródłowy Kick Assembler
cat << 'EOF' > src/main.asm
// Plik: src/main.asm
* = $0801 ; Adres startowy dla BASIC
:BasicUpstart(main)
.const SCREEN = $0400
main:
    lda #$93, jsr $ffd2
    ldx #0
loop:
    lda message,x, beq done
    sta SCREEN,x, inx, jmp loop
done:
    rts
message:
    .text "hello from a pre-built image!"
    .byte 0
EOF

# Utwórz uproszczony plik dla GitHub Actions
cat << 'EOF' > .github/workflows/build.yml
name: Build C64 Program

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v3

    - name: Run compilation
      run: |
        mkdir -p out
        docker run --rm -v ${{ github.workspace }}:/src ghcr.io/amarcinkowski/super64setup kickass src/main.asm -o out/main.prg

    - name: Upload artifact
      uses: actions/upload-artifact@v3
      with:
        name: c64-program
        path: out/main.prg
EOF

# Utwórz zaktualizowany plik README.md
cat << 'EOF' > README.md
# KickAssembler C64 Project (Simplified)

This project compiles Commodore 64 programs using the pre-built `amarcinkowski/super64setup` Docker image.

## How to build locally

No `docker build` needed! Just run the compilation command:

```bash
docker run --rm -v "$(pwd)":/src amarcinkowski/super64setup kickass src/main.asm -o out/main.prg

EOF
