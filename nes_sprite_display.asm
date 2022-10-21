
	include "nesdefs.dasm"

;;;;; VARIABLES

	seg.u ZEROPAGE
	org $0

;;;;; NES CARTRIDGE HEADER

	NES_HEADER 0,2,1,NES_MIRR_HORIZ ; mapper 0, 2 PRGs, 1 CHR

;;;;; START OF CODE

Start:	subroutine
	NES_INIT	; set up stack pointer, turn off PPU
        jsr WaitSync	; wait for VSYNC
        jsr ClearRAM	; clear RAM
        jsr WaitSync	; wait for VSYNC (and PPU warmup)
        
        jsr nametables_clear
        jsr sprite_clear
        
        lda #CTRL_NMI
        sta PPU_CTRL	; enable NMI
        lda #MASK_COLOR
        sta PPU_MASK	; enable rendering
        
        
        
.endless
	jmp .endless	; endless loop

;;;;; COMMON SUBROUTINES

	include "nesppu.dasm"
	include "util.asm"
	include "controller.asm"
	include "palette_handler.asm"
	include "display_handler.asm"

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

	

;;;;; INTERRUPT HANDLERS

NMIHandler: subroutine
	SAVE_REGS
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
        
        ; set current sprite
        lda #$0a
        sta spr_current
        
        jsr player_controls_read
	jsr display_handler
        
        ; default player palette 
	lda #$14
        sta palette_cache+13
	lda #$21
        sta palette_cache+14
	lda #$37
        sta palette_cache+15
        
	; each level has its own palette
	lda #$0f
        sta palette_cache
	ldy phase_level
        ldx palette_level_offset_table,y
	ldy #15
        jsr palette_load
        jsr palette_load
        jsr palette_load
        
	RESTORE_REGS
	rti

;;;;; CPU VECTORS

	NES_VECTORS

;;;;; GRAPHX
	org $010000
	incbin "guntner.chr"