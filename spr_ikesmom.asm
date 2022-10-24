spr_ikesmom:

	ldy #2
        ldx palette_level_offset_table,y
	ldy #15
        jsr palette_load
        jsr palette_load
        jsr palette_load
        
        
	ldy #$00
        
        lda #$78
        xaddoff
        jsr sprite_4_set_x
        lda #$67
        yaddoff
        jsr sprite_4_set_y

        lda #$22
        jsr sprite_4_set_sprite
        lda #$02
        jsr sprite_4_set_palette
        
	rts
