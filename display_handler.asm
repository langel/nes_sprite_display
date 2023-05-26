

        
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
        byte <spr_batteries	; 13
	byte <spr_bomb		; 14
	byte <spr_shroom	; 15
	byte <spr_rbag		; 16
	byte <spr_skull		; 17
	byte <spr_1up		; 18
        byte <spr_moufs		; 19
	byte <spr_vamp		; 1a
	byte <spr_scarab	; 1b
	byte <spr_swordtner	; 1c
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
        byte >spr_batteries	; 13
	byte >spr_bomb		; 14
	byte >spr_shroom	; 15
	byte >spr_rbag		; 16
	byte >spr_skull		; 17
	byte >spr_1up		; 18
        byte >spr_moufs		; 19
	byte >spr_vamp		; 1a
	byte >spr_scarab	; 1b
	byte >spr_swordtner	; 1c

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
	; b goes backwards
	lda player_controls_debounced
        and #%01000000
        beq .not_b
        dec spr_current
        bpl .not_b
        lda #spr_count
        sta spr_current
        dec spr_current
.not_b
	; a goes forward
	lda player_controls_debounced
        and #%10000000
        beq .not_a
        inc spr_current
        lda spr_current
        cmp #spr_count
        bcc .not_a
        lda #$00
        sta spr_current
.not_a
	; select selects bg mode
	lda player_controls_debounced
        and #%00100000
        beq .not_sel
        inc bg_mode
.not_sel
	; start toggles bg/spr
	lda player_controls_debounced
        and #%00010000
        beq .not_sta
        inc bg_hide
.not_sta
        
.bg_set_colors
	lda bg_hide
        and #$01
        bne .bg_hidden
        lda bg_mode
        and #$01
        bne .bg_invert
.bg_covert
	lda #$0f
        sta palette_cache
        lda #$30
        sta palette_cache+1
        bne .bg_done
.bg_invert
	lda #$30
        sta palette_cache
        lda #$0f
        sta palette_cache+1
.bg_done
	rts
.bg_hidden
	lda #$0f
        sta palette_cache
        sta palette_cache+1

.jmp_to_sprite_handler
	ldx spr_current
        lda spr_ent_lo,x
        sta temp00
        lda spr_ent_hi,x
        sta temp01
        jmp (temp00)
        
	; rts done inside jmp subroutine