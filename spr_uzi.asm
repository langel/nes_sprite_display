spr_uzi:

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

        lda #$ec
        jsr sprite_4_set_sprite
        lda #$01
        jsr sprite_4_set_palette
        
	rts
