

moufs_oam_offset_table:
	byte $b0, $c0, $e0, $d0
moufs_sprite_offset_table:
	byte $00, $10, $20, $30
moufs_y_offset_table:
	byte $00, $08, $0d, $10
        
spr_moufs:

	lda #$74
        xaddoff
        sta state_v4
	lda #$60
        yaddoff
        sta state_v5
        
        ldx #$00
        lda palette_boss_offset_table,x
	tax
        ldy #15
        jsr palette_load
        jsr palette_load


.look_down
	lda #$d6 ; c6
.look_set_sprites
        sta oam_ram_spr+$40
        sta oam_ram_spr+$44
        inc oam_ram_spr+$44
        
        lda state_v4
        sta oam_ram_x+$40
        clc
        adc #$11
        sta oam_ram_x+$44
        lda state_v5
        sbc #$04
        sta oam_ram_y+$40
        sta oam_ram_y+$44
        lda #$02
        sta oam_ram_att+$40
        sta oam_ram_att+$44
        
        
	; set upper lip default sprite
        lda #$00
        sta state_v6
        
        ldx #$00
.mouf_sprites_loop
	ldy moufs_oam_offset_table,x
	; sprite
	; a = left tile id
        ; y = oam ram offset
        cpx #$02
        bcs .sprite_normal
.sprite_custom
	lda state_v6
        bne .sprite_chosen
.sprite_normal
        lda #$86
.sprite_chosen
	clc
        adc moufs_sprite_offset_table,x
	sta oam_ram_spr,y
        clc
        adc #$01
	sta oam_ram_spr+$04,y
        adc #$01
	sta oam_ram_spr+$08,y
	; x
        ; a = x pos
        ; y = oam ram offset
        lda state_v4
	sta oam_ram_x,y
	clc
	adc #$08
	sta oam_ram_x+$04,y
	adc #$08
	sta oam_ram_x+$08,y
	adc #$08
	sta oam_ram_x+$0c,y
        ; y
	; a = y pos
        ; y = oam ram offset
        lda state_v5
        clc
        adc moufs_y_offset_table,x
        cpx #$02
        bcc .no_y_adjustments
        cpx #$03
        beq .bottom_sprite
.almost_bottom_sprite
        adc temp02
        bne .no_y_adjustments
.bottom_sprite
	adc temp03
.no_y_adjustments
	sta oam_ram_y,y
	sta oam_ram_y+$04,y
	sta oam_ram_y+$08,y
        ; pal / attr
        lda #$01
        jsr sprite_4_set_palette_no_process
        ; check next
        inx
        cpx #$04
        bne .mouf_sprites_loop
        
	rts
        
        
        
        
        
        
        
spr_vamp:

	rts
        
        
        
spr_scarab:

	rts
        
        
        
spr_swordtner:

	rts
        
        
        
