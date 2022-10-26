
oam_ram_x      = $0203
oam_ram_y      = $0200
oam_ram_spr    = $0201
oam_ram_att    = $0202

temp00 =	$00
temp01 =	$01
temp02 =	$02
temp03 =	$04

rng0 =		$08

spr_temp00 =	$10
boss_temp =	$1a
boss_eyes_pal =	$1b

state_v2 =	$22
state_v3 =	$23
state_v4 =	$24
state_v5 =	$25
state_v6 =	$26
state_v7 =	$27

player_x_hi = 	$30
player_y_hi =	$31

spr_offset_x = $38
spr_offset_y = $39
spr_current  = $3a ; which enemy shown
spr_count EQM	$1d

bat_array =	$60

player_controls	=	$80
player_controls_debounced = $81

palette_cache	EQU $e0



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
        
        
        
;;;;; RANDOM NUMBERS

get_next_random: subroutine
	lda rng0
        jsr NextRandom
        sta rng0
        rts

NextRandom subroutine
	lsr
        bcc .NoEor
        eor #$d4
.NoEor:
	rts
; Get previous random value
PrevRandom subroutine
	asl
        bcc .NoEor
        eor #$a9
.NoEor:
        rts
        
        

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
        
        
        
        
        
        
        
sine_table:
	hex 808386898c8f9295
	hex 989b9ea2a5a7aaad
	hex b0b3b6b9bcbec1c4
	hex c6c9cbced0d3d5d7
	hex dadcdee0e2e4e6e8
	hex eaebedeef0f1f3f4
	hex f5f6f8f9fafafbfc
	hex fdfdfefefeffffff
	hex fffffffffefefefd
	hex fdfcfbfafaf9f8f6
	hex f5f4f3f1f0eeedeb
	hex eae8e6e4e2e0dedc
	hex dad7d5d3d0cecbc9
	hex c6c4c1bebcb9b6b3
	hex b0adaaa7a5a29e9b
	hex 9895928f8c898683
	hex 807c797673706d6a
	hex 6764615d5a585552
	hex 4f4c494643413e3b
	hex 393634312f2c2a28
	hex 2523211f1d1b1917
	hex 151412110f0e0c0b
	hex 0a09070605050403
	hex 0202010101000000
	hex 0000000001010102
	hex 0203040505060709
	hex 0a0b0c0e0f111214
	hex 1517191b1d1f2123
	hex 25282a2c2f313436
	hex 393b3e414346494c
	hex 4f5255585a5d6164
	hex 676a6d707376797c
        
        


sine_7bits equ $0480
sine_6bits equ $0500
sine_5bits equ $0580
sine_4bits equ $0600
sine_3bits equ $0680
sine_2bits equ $0700
sine_1bits equ $0780




; 40 bytes
sine_init: subroutine
	ldx #$00
        ldy #$00
.loop
	lda sine_table,y
        lsr
        sta sine_7bits,x
        lsr
        sta sine_6bits,x
        lsr
        sta sine_5bits,x
        lsr
        sta sine_4bits,x
        lsr
        sta sine_3bits,x
        lsr
        sta sine_2bits,x
        lsr
        sta sine_1bits,x
        inx
        iny
        iny
        bne .loop
        rts
       

; 61 bytes
sine_of_scale: subroutine
	; returns scaled value of sine table
	; a = sine max
        ; x = sine pos
	eor #$ff
        sta temp00
        ; half x for lookup table
        txa
        lsr
        tax
        lda #$00
        lsr temp00
        lsr temp00
        bcs .not_1bits
        adc sine_1bits,x
.not_1bits
        lsr temp00
        bcs .not_2bits
        adc sine_2bits,x
.not_2bits
        lsr temp00
        bcs .not_3bits
        adc sine_3bits,x
.not_3bits
        lsr temp00
        bcs .not_4bits
        adc sine_4bits,x
.not_4bits
        lsr temp00
        bcs .not_5bits
        adc sine_5bits,x
.not_5bits
        lsr temp00
        bcs .not_6bits
        adc sine_6bits,x
.not_6bits
        lsr temp00
        bcs .not_7bits
        adc sine_7bits,x
.not_7bits
	rts
        
        

