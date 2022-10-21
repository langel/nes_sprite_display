spr_galger:

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
        lda #$7f
        sta oam_ram_spr,y
        
        
   	; sprite 01
        yadd4
        lda #$84
        xaddoff
        sta oam_ram_x,y
        lda #$6c
        yaddoff
        sta oam_ram_y,y
        lda #$41
        sta oam_ram_att,y
        lda #$7f
        sta oam_ram_spr,y

        
	rts
