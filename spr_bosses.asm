

; temp00 = eye sprite x origin
; temp01 = eye sprite y origin

enemy_boss_eyes: subroutine
        ; EYE SPRITE
.now_lets_add_eyes
	ldx #$fc
        lda #$a9
        sta oam_ram_spr,x
        lda boss_eyes_pal
        sta oam_ram_att,x
        ; find x
        lda temp00
        sta oam_ram_x,x
        ; check if rudy is left of vampire
        cmp player_x_hi
        bcc .looking_right
.looking_left
        lda #$99
        sta oam_ram_spr,x
	;inc oam_ram_x,x
.looking_right
	; find y
        ldy temp01
        iny
        tya
        sta oam_ram_y,x
        clc
        adc #$1c
        sec
        sbc player_y_hi
        bcc .looking_down
        clc
        adc #$cc
        bcs .looking_up
.looking_across
	lda oam_ram_spr,x
        cmp #$99
        beq .adjust_for_left_looking
        jmp .done
.adjust_for_left_looking
        rts
.looking_up
	dec oam_ram_y,x
        rts
.looking_down
	inc oam_ram_y,x
.done
	rts
        
        

moufs_oam_offset_table:
	byte $b0, $c0, $e0, $d0
moufs_sprite_offset_table:
	byte $00, $10, $20, $30
moufs_y_offset_table:
	byte $00, $08, $0d, $11
        
spr_moufs:

	; state vars
	lda #$74
        xaddoff
        sta state_v4
	lda #$60
        yaddoff
        sta state_v5
        
        ;palette
        ldx #$00
        lda palette_boss_offset_table,x
	tax
        ldy #15
        jsr palette_load
        jsr palette_load


.look_dir
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
        
        
        
        
        
        
; things the bat entities need to know
; boss_x  : center offset
; boss_y  : center offset
; state_v0 : state
; state_v1 : spawn x to target
; state_v2 : x sine position
; state_v3 : y position 
; state_v4 : bat circle size / other states counter
; state_v5 : bat visibility
; state_v6 : rng target
; state_v7 : mouth frame current
; enemy_ram_pc : mouth frame target
; enemy_ram_ac : idle_update counter
; enemy_ram_ex : arctang direction
        
spr_vamp:
	; state vars
	lda #$78
        xaddoff
        sta state_v4
	lda #$68
        yaddoff
        sta state_v5
        
        ;palette
        ldx #$01
        lda palette_boss_offset_table,x
	tax
        ldy #15
        jsr palette_load
        jsr palette_load
        
                ; set eye color
        lda #$02
        sta boss_eyes_pal
        lda #$00
        sta state_v7
        


; STATE behavior     
	ldy #$a0
        lda state_v4
        jsr sprite_4_set_x
        lda state_v5
        jsr sprite_4_set_y

	lda state_v7
        asl
        clc
        adc #$9a
        jsr sprite_4_set_sprite
        
        ; palette
        lda #$01
        jsr sprite_4_set_palette
        
        ; eyeballs
        lda oam_ram_x,y
        clc
        adc #$03
        sta temp00
        lda oam_ram_y,y
        sta temp01
	; eyeballs tho
	ldx #$fc
        lda #$a9
        sta oam_ram_spr,x
        lda boss_eyes_pal
        sta oam_ram_att,x
        lda temp00
        sta oam_ram_x,x
        lda temp01
        sta oam_ram_y,x
        
        ; target count of bat underlings; 
        ; #$0d = 13 but we `bpl loopin`
        ldy #$0c
        sta temp00 
        ; set temp counters to 0
        lda #$00
        sta temp01
        sta temp02
.bat_spawn_loop
	; a = animation counter / v1
	; x = slot in enemy ram 
        lda temp01
        ldx temp02
        sta bat_array,x
        clc
        adc #$14
        sta temp01
        inc temp02
	dey 
        bpl .bat_spawn_loop
        
        
        lda #$0c
        sta boss_temp
        ldy #$00
.bat_draw_loop
        ; update x pos
        ldx boss_temp
        lda bat_array,x
        sta temp01 ; position on circle
        lda #$40
	sta temp02 ; size of circle
        lsr
        sta temp03 ; half of circle size
        lda temp02
        ldx temp01
        jsr sine_of_scale
        clc
        adc state_v4
        adc #$04
        sec
        sbc temp03 
        sta oam_ram_x,y
        ; update y pos
        lda temp01
        clc
        adc #$40
        tax
        lda temp02
        jsr sine_of_scale
        clc
        adc state_v5
        adc #$04
        sec
        sbc temp03
        sta oam_ram_y,y
        ; interpret animation frame
        ldx boss_temp
        lda bat_array,x
        lsr
        lsr
        and #%00000011
	clc
        adc #$38
        sta oam_ram_spr,y
        ; palette
        lda #$02
        sta oam_ram_att,y
        iny
        iny
        iny
        iny
        dec boss_temp
        bpl .bat_draw_loop
        

	rts
        
        
        
        
        
        
        ;   KNOW
        ;  THYSELF
        ; DEATHLESS
        
scarab_oam_offset_table:
	byte $c0, $d0, $e0, $f0
scarab_wing_y_offset_table:
	byte $f4, $e4, $0c, $1c
scarab_wing_sprite_table:
	byte $80, $60, $80, $60
        
        
spr_scarab:

; things the bat entities need to know
; boss_x  : topleft offset
; boss_y  : topleft offset
; state_v2 : x sine position
; state_v3 : y sine position
; state_v4 : x body position
; state_v5 : y body position
; state_v6 : x wing position
; state_v7 : y wing position

; scarab palette
; $0c, $27, $38
        
        ;palette
        ldx #$02
        lda palette_boss_offset_table,x
	tax
        ldy #15
        jsr palette_load
        jsr palette_load

	; claim highest 4 sprite slot for beetle body
	;ldx #boss_scarab_id
        ; setup initial state
        lda #$78
        sta state_v4
        lda #$64
        sta state_v5
        lda #$00
        sta state_v3
        sta state_v6
        sta state_v7
        lda #$c0
        sta state_v2
        
        ; MAIN BODY
	ldy #$00
	; x pos
        lda state_v4
        jsr sprite_4_set_x
        
        ; y pos
        lda state_v5
        jsr sprite_4_set_y
        
	; sprite
        lda #$a0
        jsr sprite_4_set_sprite
        
; WINGS
	; twitch offset
        inc state_v7
        lda state_v7
        cmp #3
        bne .state_v7_dont_reset
        lda #0
        sta state_v7
.state_v7_dont_reset
	lda #$ff
        and #1
        sta state_v6
        
        
		
	; palette
	lda #$02
        jsr sprite_4_set_palette
        beq .hit
        sec
        sbc #$01
.hit
	sta temp01
        
        ; calc x pos of wing set
        lda state_v4
        sec
        sbc #$6
        clc
        adc state_v6
        sta temp00
		
		
	ldx #$03
.wing_sprites_loop
	ldy scarab_oam_offset_table,x
	; x
	lda temp00
        jsr sprite_4_set_x
	; y
	lda state_v5
	clc
	adc scarab_wing_y_offset_table,x
	jsr sprite_4_set_y
        ; sprite
	lda scarab_wing_sprite_table,x
        ; flipped wing?
        cpx #$02
        bcc .no_flip
        jsr sprite_4_set_sprite_flip
        ; att flipped
        lda temp01
        ora #$80
        bne .sprite_done
.no_flip
        jsr sprite_4_set_sprite
	; att
	lda temp01
.sprite_done
        jsr sprite_4_set_palette_no_process
	dex
	bpl .wing_sprites_loop
        
; bullet/sun
	ldy #$10
        lda state_v4
        adc #$10
        sta oam_ram_x,y
        lda state_v5
        adc #$04
        sta oam_ram_y,y
        lda #$fe
        sta oam_ram_spr,y
        lda #$01
        sta oam_ram_att,y
	rts
        
        
        
        
        
        
        
        
swordtner_metasprite_offset:
	byte	#$10, #$20, #$30, #$40
swordtner_metasprite_id:
	byte 	#$82, #$a2, #$a2, #$c2
        
        
spr_swordtner:
        ;palette
        ldx #$03
        lda palette_boss_offset_table,x
	tax
        ldy #15
        jsr palette_load
        jsr palette_load

        ; set eye color
        lda #$01
        sta boss_eyes_pal
        
        
; SWORDTNER
; MAIN BODY

        
        ;pos
        lda #$78
        sta state_v4
        lda #$48
        sta state_v5
        
        ; handle sprite
        ldy #$00
        lda #$62
        jsr sprite_4_set_sprite
        lda state_v4
        jsr sprite_4_set_x
        lda state_v5
        jsr sprite_4_set_y
        lda #$01
        jsr sprite_4_set_palette
        
	ldx #$03
.next_meta_sprite
	lda swordtner_metasprite_offset,x
        tay
        lda state_v4
        jsr sprite_4_set_x
        lda state_v5
        adc swordtner_metasprite_offset,x
        jsr sprite_4_set_y
        ; check for face animation
        cpx #$00
        bne .not_face_sprite
        lda state_v6
        beq .normal_sprite
        dec state_v6
        lda #$84
        bne .plot_sprite
.not_face_sprite
	; check for 2nd form
        lda state_v7
        beq .normal_sprite
        lda swordtner_metasprite_id,x
        clc
        adc #$02
        bne .plot_sprite
.normal_sprite
        lda swordtner_metasprite_id,x
.plot_sprite
        jsr sprite_4_set_sprite
        lda #$02
        jsr sprite_4_set_palette
        dex
        bpl .next_meta_sprite
        
        ldx #$00
        ldy #$00
        
        
        ; eyeballs setup
        ldy #$f0
        lda state_v4
        clc 
        adc #$04
        sta temp00
        lda state_v5
        clc
        adc #$10
        sta temp01
        jsr enemy_boss_eyes
        
	rts
        
        
        
