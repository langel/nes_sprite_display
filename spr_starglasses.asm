spr_starglasses:

        jsr palette_set_default
        
	ldy #$00
        
        lda #$78
        xaddoff
        jsr sprite_4_set_x
        lda #$67
        yaddoff
        jsr sprite_4_set_y

        lda #$7c
        jsr sprite_4_set_sprite
        lda #$03
        jsr sprite_4_set_palette
        
        yadd4
        yadd4
        yadd4
        yadd4
        lda #$84
        xaddoff
        jsr sprite_4_set_x
        lda #$73
        yaddoff
        jsr sprite_4_set_y

        lda #$7a
        jsr sprite_4_set_sprite
        lda #$03
        jsr sprite_4_set_palette
        
	rts

