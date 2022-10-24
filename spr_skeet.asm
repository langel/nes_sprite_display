

        byte #$a2, #$d2, #$62, #$22 

spr_skeet:

	; palette
        lda #$17
        sta palette_cache+16
        lda #$38
        sta palette_cache+17
        lda #$21
        sta palette_cache+18

        
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$67
        yaddoff
        sta oam_ram_y,y
        lda #$21
        sta oam_ram_att,y
        lda #$4e
        sta oam_ram_spr,y
        
        
   	; sprite 01
        yadd4
        lda #$84
        xaddoff
        sta oam_ram_x,y
        lda #$6c
        yaddoff
        sta oam_ram_y,y
        lda #$a1
        sta oam_ram_att,y
        lda #$4f
        sta oam_ram_spr,y
        
        
	rts
