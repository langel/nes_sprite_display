
spr_crossbones:



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
        
        
        rts
