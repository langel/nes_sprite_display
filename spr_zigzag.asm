
spr_zigzag:

        
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$83
        sta oam_ram_att,y
        lda #$5a
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$84
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$03
        sta oam_ram_att,y
        lda #$5c
        sta oam_ram_spr,y
        
   	; sprite 02
        yadd4
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$c3
        sta oam_ram_att,y
        lda #$5d
        sta oam_ram_spr,y
        
   	; sprite 03
        yadd4
        lda #$84
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$43
        sta oam_ram_att,y
        lda #$5f
        sta oam_ram_spr,y
        
        
	rts