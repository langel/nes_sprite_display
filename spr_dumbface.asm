spr_dumbface:

	; palette
        lda #$03
        sta palette_cache+16
        lda #$24
        sta palette_cache+17
        lda #$28
        sta palette_cache+18
        
	ldy #$00
        
        lda #$78
        xaddoff
        jsr sprite_4_set_x
        lda #$67
        yaddoff
        jsr sprite_4_set_y

        lda #$c8
        jsr sprite_4_set_sprite
        lda #$01
        jsr sprite_4_set_palette
	rts
