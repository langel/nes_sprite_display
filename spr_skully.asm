spr_skully:

        jsr palette_set_default
        
	ldy #$00
        
        lda #$78
        xaddoff
        jsr sprite_4_set_x
        lda #$67
        yaddoff
        jsr sprite_4_set_y

        lda #$02
        jsr sprite_4_set_sprite
        lda #$03
        jsr sprite_4_set_palette
        
	rts
