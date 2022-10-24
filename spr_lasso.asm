spr_lasso:

        jsr palette_set_default
        
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
        lda #$6a
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
        lda #$6a
        sta oam_ram_spr,y
       
   	; sprite 02
        yadd4
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$02
        sta oam_ram_att,y
        lda #$59
        sta oam_ram_spr,y
        
   	; sprite 03
        yadd4
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$78
        yaddoff
        sta oam_ram_y,y
        lda #$02
        sta oam_ram_att,y
        lda #$69
        sta oam_ram_spr,y
        
        
	rts
