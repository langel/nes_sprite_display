spr_ant:

	; palette
        lda #$03
        sta palette_cache+16
        lda #$22
        sta palette_cache+17
        lda #$28
        sta palette_cache+18

; top ant
	ldy #$00
        
        lda #$78
        xaddoff
        jsr sprite_4_set_x
        lda #$64
        yaddoff
        jsr sprite_4_set_y

        lda #$e0
        jsr sprite_4_set_sprite_flip
        lda #$81
        jsr sprite_4_set_palette
        
; bottom ant       
	ldy #$10
        
        lda #$78
        xaddoff
        jsr sprite_4_set_x
        lda #$78
        yaddoff
        jsr sprite_4_set_y

        lda #$ea
        jsr sprite_4_set_sprite
        lda #$01
        jsr sprite_4_set_palette

	rts
