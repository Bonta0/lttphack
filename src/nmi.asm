pushpc
;======================================================================================
; Improves the speed of OAM clearing by 2 scanlines; credit: MathOnNapkins
; Has no effect on anything
; But it gives us consistent improvements to account for practice hack lag
;======================================================================================
org $00841E
	; 246,16 : 250,18
	; Vanilla OAM cycles: 4 scanlines + 2 H
	; improved to: 2 scanlines + 28H

	REP #$10

	; first half
	LDX #$8001 : STX $4300

	LDA.b #OAM_Cleaner>>16 : STA $4304
	TXA ; give A 0x01

	LDX #$0801 : STX $2181 : STZ $2183

	LDX.w #OAM_Cleaner : STX $4302
	LDX #$0080 : STX $4305
	STA $420B

	; second half
	LDX.w #OAM_Cleaner : STX $4302
	LDX #$0901 : STX $2181
	LDX #$0080 : STX $4305

	STA $420B

	JSL CacheSA1Stuff

	LDX.w #$1801
	STX.w $4300
	SEP #$30
	RTS
warnpc $008489

; NMI hook
org $0080D5
	; 0080D1 LDA #$0000
	; 0080D4 TCD
	; 0080D5 PHK
	; 0080D6 PLB
	; 0080D7 SEP #$30
	JSL nmi_expand

org $008174
LDA $1C : STA $AB : NOP
LDA $1D : STA $AC : NOP

;org $0081A0 ; save camera correction for NMI expansion
;	BRA + ; save time during NMI
;org $0081B8 : +

; HUD update hook
org $008B6B
	; 008b6b ldx $0219
	; 008b6e stx $2116
	;JSL nmi_hud_update
	;NOP #2

;org $008220
org $00821B
	; LDA $9B
	; STA $420C
	JSL nmi_hud_update
	NOP

; NMI HOOK
org $0089C2
nmi_hook:
	TCD : PHK : PLB
	JSL nmi_expand
	RTS

warnpc $0089DF
; Unused $17 function repurposed
org $008C8A
	dw NMI_UpdatePracticeHUD ; $17=0x06

org $00EA79 ; seems unused
NMI_UpdatePracticeHUD:
	REP #$20
	LDX #$80 : STX $2115
	LDA #$6C00 : STA $2116

	LDA #$1801 : STA $4300
	LDA.w #!menu_dma_buffer : STA $4302
	LDX.b #!menu_dma_buffer>>16 : STX $4304
	LDA #$0800 : STA $4305

	LDX #$01 : STX $420B
	SEP #$20
	RTS

warnpc $00EAE5

; The time this routine takes isn't relevant
; since it's never during game play
org $00E36A
	JSL LoadCustomHUDGFX
	PLB : RTL

pullpc

; Needs to leave AI=8
nmi_expand:
	; enters AI=16
	SEP #$30
	; this covers the PHK : PLB we overwrote
	PHA ; A is 0 from right before the hook
	PLB ; and that happens to be the bank we want

	LDA !disabled_layers : TRB $AB : TRB $AC
	REP #$20
	LDA $AB : STA $212C

	SEP #$30
	LDA #$10
	STA.w $2200
	STZ.w !lowram_last_frame_did_saveload
	RTL

nmi_hud_update:
	; Movie stuff commented out while it's not needed
;	LDX #$6360 : STX $2116

;	; $7EC700 is the WRAM buffer for this data
;	LDX.w #!ram_movie_hud : STX $4302
;	LDA.b #!ram_movie_hud>>16 : STA $4304
;	LDX #$0040 : STX $4305 ; number of bytes to transfer is 330
;	LDA #$01 : STA $420B ; refresh BG3 tilemap data with this transfer on channel 0
	REP #$21 ; carry only needs clearing once
	SEP #$10

	LDX !lag_cache : BNE .dontbreakthings
	LDA.l !ram_superwatch
	AND #$0003
	ASL
	TAX
	JMP (.routines, X)

.doorwatch
	LDX #$80 : STX $2115
	LDA #$6500 : STA $2116

	LDA #$1801 : STA $4300
	LDA.w #!dg_dma_buffer : STA $4302
	LDX.b #!dg_dma_buffer>>16 : STX $4304
	LDA #$0100 : STA $4305

	LDY #$01 : STY $420B

.nowatch
	; force heartlag update
	LDX !do_heart_lag : BEQ .dontbreakthings
	LDA #$C118>>1 : STA $2116
	LDA.l !POS_MEM_HEARTLAG : STA $2118

.dontbreakthings
	STZ !do_heart_lag
	LDX $13
	STX $2100

	RTL

.ancillawatch
	LDX $10
	CPX #$06 : BCC .nowatch
	CPX #$19 : BCS .nowatch
	CPX #$12 : BEQ .nowatch
	CPX #$14 : BEQ .nowatch

	LDX #$80 : STX $2115
	LDY #$01
	LDA #$1801 : STA $4300
	LDA.w #!dg_dma_buffer : STA $4302
	LDX.b #!dg_dma_buffer>>16 : STX $4304

	LDA #$C202>>1 : STA $2116
	LDA #$0010 : STA $4305
	STY $420B

macro draw_ancilla_row(n)
	LDA #($C202+(64*<n>))>>1 : STA $2116
	LDA #$0010 : STA $4305
	STY $420B

	;LDA #($C22E+(64*<n>))>>1 : STA $2116
	;LDA #$0010 : STA $4305
	;STY $420B
endmacro

	;%draw_ancilla_row(1)
	%draw_ancilla_row(2)
	%draw_ancilla_row(3)
	%draw_ancilla_row(4)
	%draw_ancilla_row(5)
	%draw_ancilla_row(6)
	;%draw_ancilla_row(7)
	%draw_ancilla_row(8)
	%draw_ancilla_row(9)
	%draw_ancilla_row(10)
	%draw_ancilla_row(11)
	%draw_ancilla_row(12)
	;%draw_ancilla_row(13)
	;%draw_ancilla_row(14)
	;%draw_ancilla_row(15)
	;%draw_ancilla_row(16)
	;%draw_ancilla_row(17)
	;%draw_ancilla_row(18)
	;%draw_ancilla_row(19)
	;%draw_ancilla_row(20)

	JMP .nowatch

.routines
	dw .nowatch
	dw .ancillawatch
	dw .doorwatch
	dw .nowatch

;===========================================
; OAM cleaner optimization
;===========================================
macro OAMVClear(pos)
	db $F0, <pos>+$05, $F0, <pos>+$09, $F0, <pos>+$0D, $F0, <pos>+$11
endmacro

OAM_Cleaner:
	%OAMVClear($00)
	%OAMVClear($10)
	%OAMVClear($20)
	%OAMVClear($30)
	%OAMVClear($40)
	%OAMVClear($50)
	%OAMVClear($60)
	%OAMVClear($70)
	%OAMVClear($80)
	%OAMVClear($90)
	%OAMVClear($A0)
	%OAMVClear($B0)
	%OAMVClear($C0)
	%OAMVClear($D0)
	%OAMVClear($E0)
	%OAMVClear($F0)