
; G u n T n e R

; BIG TITLE
big_title_init: subroutine
	PPU_SETADDR $2120
        ldy #$00
big_title_loop:
	lda guntner_title_name_table,y
	sta PPU_DATA
        iny
        bne big_title_loop
        rts
        
                        
guntner_title_name_table:  ; 256 bytes
	byte $03,$03,$03,$c1,$c2,$c3,$c4,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2
	byte $c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c5,$03,$03,$03
	byte $03,$03,$03,$c6,$c7,$c8,$c9,$ca,$ca,$ca,$ca,$ca,$ca,$ca,$ca,$cb
	byte $cc,$ca,$ca,$ca,$ca,$ca,$ca,$ca,$ca,$cb,$cc,$cd,$ce,$03,$03,$03
	byte $03,$03,$03,$cf,$d0,$03,$d1,$d2,$d3,$d4,$d5,$d6,$d7,$d8,$d9,$d2
	byte $d3,$d6,$d7,$d8,$d9,$da,$db,$dc,$dd,$d2,$d3,$de,$cf,$03,$03,$03
	byte $03,$03,$03,$cf,$df,$e0,$e1,$d2,$d3,$e2,$d5,$e3,$e4,$e5,$d5,$d2
	byte $d3,$e3,$e4,$e5,$d5,$d2,$e6,$e7,$d5,$d2,$e8,$e9,$ea,$03,$03,$03
	byte $03,$03,$03,$cf,$d0,$e3,$d5,$d2,$d3,$e2,$d5,$e3,$d5,$e2,$d5,$d2
	byte $d3,$e3,$d5,$e2,$d5,$d2,$eb,$ec,$ed,$d2,$d3,$e2,$ee,$03,$03,$03
	byte $03,$03,$03,$cf,$d0,$e3,$d5,$ef,$f0,$f1,$f2,$f3,$ce,$f4,$d5,$d2
	byte $d3,$f3,$ce,$f4,$d5,$ef,$f0,$f1,$f2,$d2,$f5,$f6,$cf,$03,$03,$03
	byte $03,$03,$03,$cf,$f7,$f8,$d5,$03,$03,$03,$03,$03,$03,$03,$03,$d2
	byte $d3,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$e2,$cf,$03,$03,$03
	byte $03,$03,$03,$f9,$fa,$fa,$fb,$03,$03,$03,$03,$03,$03,$03,$fc,$fa
	byte $fa,$fd,$03,$03,$03,$03,$03,$03,$03,$03,$03,$fe,$fa,$fd,$03,$03
  
