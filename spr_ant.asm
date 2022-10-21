spr_ant:


	ldy #$00
        
        lda #$78
        xaddoff
        jsr sprite_4_set_x
        lda #$67
        yaddoff
        jsr sprite_4_set_y

        lda #$e0
        jsr sprite_4_set_sprite
        lda #$03
        jsr sprite_4_set_palette
        
        
	ldy #$10
        
        lda #$78
        xaddoff
        jsr sprite_4_set_x
        lda #$78
        yaddoff
        jsr sprite_4_set_y

        lda #$ea
        jsr sprite_4_set_sprite
        lda #$03
        jsr sprite_4_set_palette

	rts
