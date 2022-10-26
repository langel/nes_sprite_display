spr_sparks:

        jsr palette_set_default
        
        jsr get_next_random
        
   	; sprite 00
        ldy #$00
        lda #$78
        xaddoff
        sta oam_ram_x,y
        lda #$67
        yaddoff
        sta oam_ram_y,y
        jsr get_next_random
        sta oam_ram_att,y
        jsr get_next_random
        lsr
        and #$03
        clc
        adc #$6c
        sta oam_ram_spr,y
        
   	; sprite 01
        yadd4
        lda #$86
        xaddoff
        sta oam_ram_x,y
        lda #$64
        yaddoff
        sta oam_ram_y,y
        jsr get_next_random
        sta oam_ram_att,y
        jsr get_next_random
        lsr
        and #$03
        clc
        adc #$6c
        sta oam_ram_spr,y
        
        
        
	rts
