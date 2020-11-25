pushpc
; Code that is run once after the game has been powered on.

; Overrides the following:
; LDA.b #$81 : STA $4200
org $00802F
	JSL init_hook
	NOP

pullpc

ClearWatchBuffer:
	PHX
	PHA
	PHP
	REP #$20
	SEP #$10
	LDA #$207F
	LDX #$3E

--	STA.w !dg_buffer_r0, X
	STA.w !dg_buffer_r1, X
	STA.w !dg_buffer_r2, X
	STA.w !dg_buffer_r3, X
	STA.w !dg_buffer_r4, X
	DEX : DEX : BPL --

	PLP
	PLA
	PLX
	RTL

.pre
	STA.b $CA ; vanilla code
	SEP #$30
	BRA ClearWatchBuffer

init_hook:
	JSL init_expand
	JSL InitSA1

	SEP #$30
	LDA #$81 : STA $4200
	RTL

init_expand:
	LDA #$01 : STA $420D ; enable fast rom
	; enters AI=8
	; If user holds Start+Select, we reinitialize.
	; we need some manual joypad reading
	LDA #$01 : STA $4016 : STZ $4016 ; pulse controller

	STZ $00 : STZ $01
	LDY #$10 ; reading 16 bits
--	LDA $4016 ; if the last bit is on, carry will be set, otherwise, it won't; A is still 1
	LSR
	ROL $00 : ROL $01 ; roll carry from A and then from $00
	DEY : BNE -- ; decrement

	REP #$20
	LDA $00
	AND #$FF00 : CMP #$3000 : BEQ .forcereset
	LDA !ram_ctrl_prachack_menu : CMP #$1010 : BEQ .noforcereset

.forcereset
	JSR init_initialize_all
	BRA .sram_initialized

.noforcereset
	LDA !ram_sram_initialized : CMP #!SRAM_VERSION : BEQ .sram_initialized

.reinitialize
	JSR init_initialize

.sram_initialized
	; Some features probably should be turned off after a reset
	SEP #$20
	STZ !lowram_oob_toggle
	LDA #$00
	STA.l !ram_superwatch
	STA.l !ram_superwatch+1
.done
	RTL

init_initialize_all:
	!PERM_INIT

init_initialize:
	!INIT_ASSEMBLY

	LDA #!SRAM_VERSION : STA !ram_sram_initialized

	REP #$10
	LDA #$0000
	LDX #$00FE

;.loop
;	STA !sram_movies, X
;	DEX #2 : BPL .loop
;	SEP #$10

	RTS
