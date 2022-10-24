spr_chomps:

	; palette
	ldy #$01
        ldx palette_level_offset_table,y
	ldy #15
        jsr palette_load
        jsr palette_load
        jsr palette_load

	
        ; top left chomps
        
   	; sprite 00
        ldy #$00
        lda #$7e
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$34
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$80
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$78
        sta oam_ram_spr,y
        
        
        
        ; bottom right chomps
        
   	; sprite 00
        yadd4
        lda #$86
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$37
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$88
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$68
        sta oam_ram_spr,y
        
        
	rts
