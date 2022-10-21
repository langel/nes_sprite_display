
oam_ram_x      = $0203
oam_ram_y      = $0200
oam_ram_spr    = $0201
oam_ram_att    = $0202

temp00 =	$00
temp01 =	$01
temp02 =	$02
temp03 =	$04

spr_temp00 =	$10



        MAC yadd4
      	iny
      	iny
      	iny
      	iny
        ENDM
        
        MAC xaddoff
        clc
        adc spr_offset_x
        ENDM
        
        MAC yaddoff
        clc
        adc spr_offset_y
        ENDM


phase_level =	$20

tile_empty 		EQM $03


nametables_clear:
	; tiles
	ldx #$07
        ldy #$00
        PPU_SETADDR $2000
        lda #tile_empty
.page_loop
.byte_loop
        sta PPU_DATA
	iny
        bne .byte_loop
        dex
        bpl .page_loop
        ; attributes
        ldy #0
        PPU_SETADDR $23c0
        ldx #$c0
.nm1_attr_loop
	sty PPU_DATA
        inx
        bne .nm1_attr_loop
        PPU_SETADDR $27c0
        ldx #$c0
.nm2_attr_loop
	sty PPU_DATA
        inx
        bne .nm2_attr_loop
        rts
        

sprite_clear:
        lda #$ff
        ldx #$00
.clear_sprite_ram
	sta oam_ram_y,x	; PPU OAM sprite data
        inx
        bne .clear_sprite_ram
	rts


sprite_4_set_palette: subroutine
	; a = palette id
        ; y = oam ram offset
	sta oam_ram_att+$00,y
        sta oam_ram_att+$04,y
        sta oam_ram_att+$08,y
        sta oam_ram_att+$0c,y
        rts
        
sprite_4_set_palette_no_process: subroutine
	; a = palette id
        ; y = oam ram offset
        sta oam_ram_att+$00,y
        sta oam_ram_att+$04,y
        sta oam_ram_att+$08,y
        sta oam_ram_att+$0c,y
        rts

sprite_4_set_sprite: subroutine
	; a = top left tile id
        ; y = oam ram offset
	sta oam_ram_spr,y
        clc
        adc #$01
	sta oam_ram_spr+$04,y
        adc #$0f
	sta oam_ram_spr+$08,y
	adc #$01
	sta oam_ram_spr+$0c,y
        rts
        
sprite_4_set_sprite_flip: subroutine
	; a = top left tile id
        ; y = oam ram offset
	sta oam_ram_spr+$08,y
        clc
        adc #$01
	sta oam_ram_spr+$0c,y
        adc #$0f
	sta oam_ram_spr,y
	adc #$01
	sta oam_ram_spr+$04,y
        rts
        
sprite_4_set_x: subroutine
	; a = x pos
        ; y = oam ram offset
	sta oam_ram_x,y
	sta oam_ram_x+$08,y
	clc
	adc #$08
	sta oam_ram_x+$04,y
	sta oam_ram_x+$0c,y
	rts
        
sprite_4_set_y: subroutine
	; a = y pos
        ; y = oam ram offset
	sta oam_ram_y,y
	sta oam_ram_y+$04,y
	clc
	adc #$08
	sta oam_ram_y+$08,y
	sta oam_ram_y+$0c,y
	rts