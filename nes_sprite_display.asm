
	include "nesdefs.dasm"

;;;;; VARIABLES

	seg.u ZEROPAGE
	org $0

;;;;; NES CARTRIDGE HEADER

	NES_HEADER 0,2,1,NES_MIRR_HORIZ ; mapper 0, 2 PRGs, 1 CHR


;;;;; COMMON SUBROUTINES

	include "nesppu.dasm"
	include "util.asm"
	include "controller.asm"
	include "palette_handler.asm"
	include "display_handler.asm"
        
	include "bg_title.asm"

	include "spr_birb.asm"
	include "spr_maggs.asm"
	include "spr_galger.asm"
	include "spr_dumbface.asm"
	include "spr_skully.asm"
	include "spr_sparks.asm"
	include "spr_chomps.asm"
	include "spr_ant.asm"
	include "spr_zigzag.asm"
	include "spr_throber.asm"
	include "spr_skeet.asm"
	include "spr_lasso.asm"
	include "spr_muya.asm"
	include "spr_uzi.asm"
	include "spr_bullet.asm"
	include "spr_ikesmom.asm"
	include "spr_player.asm"
	include "spr_crossbones.asm"
	include "spr_starglasses.asm"
	include "spr_powerups.asm"
	include "spr_bosses.asm"
        
        
;;;;; START OF CODE

Start:	subroutine
	NES_INIT	; set up stack pointer, turn off PPU
        jsr WaitSync	; wait for VSYNC
        jsr ClearRAM	; clear RAM
        jsr WaitSync	; wait for VSYNC (and PPU warmup)
        
        jsr nametables_clear
        jsr sine_init
        jsr big_title_init
        
        lda #CTRL_NMI
        sta PPU_CTRL	; enable NMI
        lda #MASK_COLOR
        sta PPU_MASK	; enable rendering
        
        ; bg is black
	lda #$0f
        sta palette_cache
        sta palette_cache+1
        sta rng0 ; start somewhere
        
        lda #$00
        sta bg_mode
        lda #$01
        sta bg_hide
        
.endless
	jmp .endless	; endless loop


;;;;; INTERRUPT HANDLERS

NMIHandler: subroutine
\\\\	SAVE_REGS
	; OAM DMA	513 cycles
	lda #$02
        sta PPU_OAM_DMA
        ; PALETTE	236 cycles
        jsr palette_render
        lda #CTRL_NMI|CTRL_BG_1000
        sta PPU_CTRL
        lda #MASK_BG|MASK_SPR
        sta PPU_MASK
	; SCROLL POS	17 cycles
	bit PPU_STATUS
        lda #0
        sta PPU_SCROLL
        sta PPU_SCROLL
        
        ; reset crap
        sta temp00
        sta temp01
        sta temp02
        sta temp03
        sta state_v7
        ; set current sprite
        ;lda #$1b
        ;sta spr_current
        
        jsr player_controls_read
        jsr sprite_clear
	jsr display_handler
        
        
	RESTORE_REGS
	rti

;;;;; CPU VECTORS

	NES_VECTORS

;;;;; GRAPHX
	org $010000
	incbin "guntner.chr"