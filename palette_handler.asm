
palette_cache	EQU $e0


;Palette00:		; 25 bytes

;	hex 0f		;screen color
;	hex 022830	;background 0
;        hex 071624	;background 1
;        hex 02113c	;background 2
;        hex 0b1a3b	;background 3
;        hex 192939	;sprite 0 ; rudy
;        hex 132130	;sprite 1; old birb palete
;       ;hex 051637	; chomps
        ;hex 122130	; vamp eyes & bats
        ;hex 071727	;sprite 2
;        hex 150037	; vamp head/face
;        hex 013530	;sprite 3 ; starglasses ; crossbones
        
        
; bg 0 - stars bg_tiles 1 / title screen
; bg 1 - stars bg_tiles 2
; bg 2 - n/a  (bg enemies haha)
; bg 3 - dashboard / options screen
; spr 0 - player
; spr 1 - enemy / darts
; spr 2 - enemy / stars sprites 1
; spr 3 - enemy / powerups / stars sprite 2


; level palettes
;	spr 1, 2 and 3
; boss palettes
;	spr 1 and 2


palette_table:
	; #00 end bad
	byte #$0f, #$30, #$27
	; #03 end ok
	byte #$0f, #$10, #$30
	; #06 end good
	byte #$0a, #$37, #$27
	; #09 end alien
        byte #$3c, #$1c, #$24
	; #12 intro bg
	byte #$0c, #$30, #$3c
	; #15 intro alien
        byte #$04, #$1b, #$37
        ; #18 title screen
        byte #$02, #$27, #$34
        ; #21 level 0 palettes (and attract mode)
        hex 13 21 30
        hex 07 17 27
        hex 01 35 30
        ; #30 level 1 palettes
        hex 06 16 38
        hex 0b 18 39
        hex 08 32 20
        ; #39 level 2 palettes
        hex 0c 2d 32
        hex 13 25 37
        hex 09 27 10
        ; #48 level 3 palettes
        hex 2d 10 30
        hex 12 23 37
        hex 07 17 27
        ; #57 boss 
        ; moufs palettes
        hex 04 16 20
        hex 02 07 38
        ; #63 boss 
        ; vamp+bats palettes
        hex 15 2d 37
        hex 02 11 30
        ; #69 boss 
        ; scarab palettes
        hex 0c 27 37
        hex 03 1a 39
        ; #75 boss 
        ; swordtner palettes
        hex 07 17 3d 
        hex 11 2d 31
        ; #81 bookbinder
        hex 0f 00 37
        
palette_level_offset_table:
	byte #21, #30, #39, #48
palette_boss_offset_table:
	byte #57, #63, #69, #75
        
        
palette_load:
	; x = palette table offset 
        ; y = pal ram offset
        ; loads 1 set of 3 colors
        ; not used to write to main bg color
        lda #$02
        sta temp00
.loader_loop
	lda palette_table,x
        sta palette_cache+1,y
        inx
        iny
	dec temp00
        bpl .loader_loop
        rts
        
        

        

	; 12 + 32 x 7 = 236 cycles
palette_render: subroutine
	PPU_SETADDR $3f00
        ldx #0
        ldy #8
.loop
	lda palette_cache
        sta PPU_DATA
        inx
        lda palette_cache,x
        sta PPU_DATA
        inx
        lda palette_cache,x
        sta PPU_DATA
        inx
        lda palette_cache,x
        sta PPU_DATA
        dey
        bne .loop
	rts
        
        
        
palette_set_default:
        ; default player palette 
	lda #$14
        sta palette_cache+15
	lda #$21
        sta palette_cache+14
	lda #$37
        sta palette_cache+13
        
	; each level has its own palette
	ldy phase_level
        ldx palette_level_offset_table,y
	ldy #15
        jsr palette_load
        jsr palette_load
        jsr palette_load
	rts
