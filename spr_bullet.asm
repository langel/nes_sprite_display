spr_bullet:

	ldy #2
        ldx palette_level_offset_table,y
	ldy #15
        jsr palette_load
        jsr palette_load
        jsr palette_load

   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$67
        yaddoff
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$ee
        sta oam_ram_spr,y
        
        
   	; sprite 01
        yadd4
        lda #$84
        xaddoff
        sta oam_ram_x,y
        lda #$6c
        yaddoff
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$ef
        sta oam_ram_spr,y
        
        
	rts
