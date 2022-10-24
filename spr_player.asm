spr_player:
        jsr palette_set_default
        
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$00
        sta oam_ram_att,y
        lda #$4a
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$80
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$00
        sta oam_ram_att,y
        lda #$4b
        sta oam_ram_spr,y
        
        rts
        
        
spr_player_hit:
        jsr palette_set_default
        
        
   	; sprite 00
        yadd4
        lda #$80
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$00
        sta oam_ram_att,y
        lda #$4c
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$88
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$00
        sta oam_ram_att,y
        lda #$4d
        sta oam_ram_spr,y
        
	rts
