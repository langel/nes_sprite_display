


spr_batteries:
   	; sprite 00
        ldy #$00
        lda #$70
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$03
        sta oam_ram_att,y
        lda #$2b
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$7a
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$03
        sta oam_ram_att,y
        lda #$2a
        sta oam_ram_spr,y
        
   	; sprite 02
        yadd4
        lda #$84
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$03
        sta oam_ram_att,y
        lda #$29
        sta oam_ram_spr,y
	rts
        
        
spr_bomb:
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$03
        sta oam_ram_att,y
        lda #$27
        sta oam_ram_spr,y
	rts
        
spr_shroom:
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$03
        sta oam_ram_att,y
        lda #$25
        sta oam_ram_spr,y
	rts
        
spr_rbag:
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$03
        sta oam_ram_att,y
        lda #$28
        sta oam_ram_spr,y
	rts
        
spr_skull:
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$03
        sta oam_ram_att,y
        lda #$24
        sta oam_ram_spr,y
	rts
        
spr_1up:
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$03
        sta oam_ram_att,y
        lda #$26
        sta oam_ram_spr,y
	rts
        

