// hello.asm — KickAssembler
* = $0801
BasicUpstart2(start)         // generuje mały program BASIC: 10 SYS <adres start>

// KERNAL: znak na ekran
.label CHROUT = $ffd2

start:
    lda #$93                 // kod: CLR/HOME — czyści ekran
    jsr CHROUT

    ldx #0
print_loop:
    lda message, x           // pobierz kolejny znak
    beq done                 // 0 = koniec tekstu
    jsr CHROUT               // wypisz znak
    inx
    bne print_loop

done:
    rts

// PETSCII (duże litery)
.encoding "petscii_upper"
message:
    .text "HELLO WORLD!", $0d  // $0d = nowa linia
    .byte 0                    // terminator
