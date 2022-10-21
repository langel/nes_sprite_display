
spr_birb:	subroutine
        
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$2c
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$84
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$2d
        sta oam_ram_spr,y
        
   	; sprite 02
        yadd4
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$2e
        sta oam_ram_spr,y
        
   	; sprite 03
        yadd4
        lda #$84
        xaddoff
        sta oam_ram_x,y
        lda #$70
        yaddoff
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$2f
        sta oam_ram_spr,y
        
        rts
