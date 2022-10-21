
spr_offset_x = $38
spr_offset_y = $39

spr_current  = $3a ; which enemy shown


display_handler:	subroutine

; reading joypad gives us a byte
; bit 7 a button
; bit 6 b button
; bit 5 select
; bit 4 start
; bit 3 up
; bit 2 down
; bit 1 left
; bit 0 right
	lda player_controls
        and #%00001000
        beq .not_up
        dec spr_offset_y
.not_up
	lda player_controls
        and #%00000100
        beq .not_down
        inc spr_offset_y
.not_down
	lda player_controls
        and #%00000010
        beq .not_left
        dec spr_offset_x
.not_left
	lda player_controls
        and #%00000001
        beq .not_right
        inc spr_offset_x
.not_right



	; set offset
        ldy #$00
        
   	; sprite 00
        lda #$78
        clc
        adc spr_offset_x
        sta oam_ram_x,y
        lda #$64
        clc
        adc spr_offset_y
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$2c
        sta oam_ram_spr,y
        
        iny
        iny
        iny
        iny
   	; sprite 01
        lda #$84
        clc
        adc spr_offset_x
        sta oam_ram_x,y
        lda #$64
        clc
        adc spr_offset_y
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$2d
        sta oam_ram_spr,y
        
        iny
        iny
        iny
        iny
   	; sprite 02
        lda #$78
        clc
        adc spr_offset_x
        sta oam_ram_x,y
        lda #$70
        clc
        adc spr_offset_y
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$2e
        sta oam_ram_spr,y
        
        iny
        iny
        iny
        iny
   	; sprite 03
        lda #$84
        clc
        adc spr_offset_x
        sta oam_ram_x,y
        lda #$70
        clc
        adc spr_offset_y
        sta oam_ram_y,y
        lda #$01
        sta oam_ram_att,y
        lda #$2f
        sta oam_ram_spr,y
        
        
        rts
