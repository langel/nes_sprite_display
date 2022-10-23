spr_muya:


   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$60
        yaddoff
        sta oam_ram_y,y
        lda #$02
        sta oam_ram_att,y
        lda #$64
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$68
        yaddoff
        sta oam_ram_y,y
        lda #$02
        sta oam_ram_att,y
        lda #$74
        sta oam_ram_spr,y
        

	rts
