
spr_offset_x = $38
spr_offset_y = $39

spr_current  = $3a ; which enemy shown
        
spr_ent_lo:
	byte <spr_birb		; 0
	byte <spr_maggs		; 1
        byte <spr_galger	; 2
        byte <spr_dumbface	; 3
        byte <spr_skully	; 4
        byte <spr_sparks	; 5
        byte <spr_chomps	; 6
        byte <spr_ant		; 7
        byte <spr_zigzag	; 8
        byte <spr_throber	; 9
        byte <spr_skeet		; a
        byte <spr_lasso		; b
        byte <spr_muya		; c
        byte <spr_uzi		; d
        byte <spr_bullet	; e
        byte <spr_ikesmom	; f
        byte <spr_player	; 10
        byte <spr_player_hit	; 11
        byte <spr_starglasses	; 12
spr_ent_hi:
	byte >spr_birb
	byte >spr_maggs
        byte >spr_galger
        byte >spr_dumbface
        byte >spr_skully
        byte >spr_sparks
        byte >spr_chomps
        byte >spr_ant
        byte >spr_zigzag
        byte >spr_throber
        byte >spr_skeet
        byte >spr_lasso
        byte >spr_muya
        byte >spr_uzi
        byte >spr_bullet
        byte >spr_ikesmom
        byte >spr_player	; 10
        byte >spr_player_hit	; 11
        byte >spr_starglasses	; 12

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


	ldx spr_current
        lda spr_ent_lo,x
        sta temp00
        lda spr_ent_hi,x
        sta temp01
        jmp (temp00)
        
	; rts done inside jmp subroutine