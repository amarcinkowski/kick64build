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
