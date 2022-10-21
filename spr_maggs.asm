;; HANDLING maggs
spr_maggs: subroutine
	
        ; top left maggs
        
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$02
        sta oam_ram_att,y
        lda #$3c
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$80
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$02
        sta oam_ram_att,y
        lda #$3d
        sta oam_ram_spr,y
        
        
        
        ; bottom right maggs
        
   	; sprite 00
        yadd4
        lda #$80
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$02
        sta oam_ram_att,y
        lda #$3e
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$88
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$02
        sta oam_ram_att,y
        lda #$3f
        sta oam_ram_spr,y
        
        
        rts
        
