spr_throber:


	; palette
        lda #$07
        sta palette_cache+16
        lda #$00
        sta palette_cache+17
        
        lda #$28
        sta palette_cache+19
        lda #$16
        sta palette_cache+20
        

	ldy #$00
        
        lda #$74
        xaddoff
        jsr sprite_4_set_x
        lda #$67
        yaddoff
        jsr sprite_4_set_y

        lda #$42
        jsr sprite_4_set_sprite
        lda #$01
        jsr sprite_4_set_palette
        
        
	ldy #$10
        
        lda #$7b
        xaddoff
        jsr sprite_4_set_x
        lda #$75
        yaddoff
        jsr sprite_4_set_y

        lda #$46
        jsr sprite_4_set_sprite
        lda #$02
        jsr sprite_4_set_palette
        
        
	rts
