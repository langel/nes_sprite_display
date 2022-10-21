
;;;;; CONTROLLER READING

player_controls	=	$f0
player_controls_debounced = $f1

; reading joypad gives us a byte
; bit 7 a button
; bit 6 b button
; bit 5 select
; bit 4 start
; bit 3 up
; bit 2 down
; bit 1 left
; bit 0 right



controller_poller: subroutine
	ldx #$01
        stx JOYPAD1
        dex
        stx JOYPAD1
        ldx #$08
.read_loop
	lda JOYPAD1
        lsr
        rol temp00
        lsr
        rol temp01
        dex
        bne .read_loop
        lda temp00
        ora temp01
        sta temp00
        rts
        


player_controls_read: subroutine

	jsr controller_poller
.checksum_loop
        ldy temp00
        jsr controller_poller
        cpy temp00
        bne .checksum_loop
        lda temp00
        tay
        eor player_controls
        and temp00
        sta player_controls_debounced
        sty player_controls
        rts
