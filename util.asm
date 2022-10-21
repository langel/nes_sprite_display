
oam_ram_x      = $0203
oam_ram_y      = $0200
oam_ram_spr    = $0201
oam_ram_att    = $0202

temp00 =	$00
temp01 =	$01
temp02 =	$02
temp03 =	$04

spr_temp00 =	$10

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
