math pri on

sa1rom

pushpc
org $008000
struct SA1IRAM $003000
	.SCRATCH: skip 12
	.CopyOf_10: skip 1
	.CopyOf_11: skip 1
	.CopyOf_12: skip 1
	.CopyOf_12_B: skip 1
	.CopyOf_1A: skip 1
	.CopyOf_1B: skip 1
	.CopyOf_20: skip 1
	.CopyOf_21: skip 1
	.CopyOf_22: skip 1
	.CopyOf_23: skip 1
	.CopyOf_24: skip 1
	.CopyOf_25: skip 1
	.CopyOf_27: skip 1
	.CopyOf_28: skip 1
	.CopyOf_29: skip 1
	.CopyOf_2A: skip 1
	.CopyOf_2B: skip 1
	.CopyOf_30: skip 1
	.CopyOf_31: skip 1
	.CopyOf_5B: skip 1
	.CopyOf_5D: skip 1
	.CopyOf_5E: skip 1
	.CopyOf_6C: skip 1
	.CopyOf_A0: skip 1
	.CopyOf_A1: skip 1
	.CopyOf_A6: skip 1
	.CopyOf_A7: skip 1
	.CopyOf_A8: skip 1
	.CopyOf_A9: skip 1
	.CopyOf_AA: skip 1
	.CopyOf_E2: skip 1
	.CopyOf_E3: skip 1
	.CopyOf_E8: skip 1
	.CopyOf_E9: skip 1
	.CopyOf_EE: skip 1

	.CONTROLLER_1:
	.CopyOf_F2: skip 1
	.CopyOf_F0: skip 1

	.CONTROLLER_1_FILTERED:
	.CopyOf_F6: skip 1
	.CopyOf_F4: skip 1

	.CopyOf_0208: skip 1
	.CopyOf_0209: skip 1
	.CopyOf_020A: skip 1
	.CopyOf_02A2: skip 1
	.CopyOf_02FA: skip 1
	.CopyOf_0400: skip 1
	.CopyOf_0401: skip 1
	.CopyOf_0402: skip 1
	.CopyOf_0403: skip 1
	.CopyOf_0408: skip 1
	.CopyOf_040A: skip 1
	.CopyOf_040C: skip 1

	.CopyOf_0600: skip 1
	.CopyOf_0601: skip 1
	.CopyOf_0602: skip 1
	.CopyOf_0603: skip 1
	.CopyOf_0604: skip 1
	.CopyOf_0605: skip 1
	.CopyOf_0606: skip 1
	.CopyOf_0607: skip 1
	.CopyOf_0608: skip 1
	.CopyOf_0609: skip 1
	.CopyOf_060A: skip 1
	.CopyOf_060B: skip 1
	.CopyOf_060C: skip 1
	.CopyOf_060D: skip 1
	.CopyOf_060E: skip 1
	.CopyOf_060F: skip 1
	.CopyOf_0610: skip 1
	.CopyOf_0611: skip 1
	.CopyOf_0612: skip 1
	.CopyOf_0613: skip 1
	.CopyOf_0614: skip 1
	.CopyOf_0615: skip 1
	.CopyOf_0616: skip 1
	.CopyOf_0617: skip 1
	.CopyOf_0618: skip 1
	.CopyOf_0619: skip 1
	.CopyOf_061A: skip 1
	.CopyOf_061B: skip 1
	.CopyOf_061C: skip 1
	.CopyOf_061D: skip 1
	.CopyOf_061E: skip 1
	.CopyOf_061F: skip 1
	.CopyOf_068E: skip 1
	.CopyOf_068F: skip 1
	.CopyOf_0690: skip 1
	.CopyOf_0691: skip 1

	.CopyOf_0B08: skip 1
	.CopyOf_0B09: skip 1

	.CopyOf_7EF36C: skip 1
	.CopyOf_7EF36D: skip 1

	.CopyOf_0BFA: skip 10
	.CopyOf_0C04: skip 10
	.CopyOf_0C0E: skip 10
	.CopyOf_0C18: skip 10
	.CopyOf_0C4A: skip 10

	.ROOM_TIME_F: skip 2
	.ROOM_TIME_S: skip 2
	.ROOM_TIME_LAG: skip 2
	.ROOM_TIME_IDLE: skip 2

	.SEG_TIME_F: skip 2
	.SEG_TIME_S: skip 2
	.SEG_TIME_M: skip 2

	.ROOM_TIME_F_DISPLAY: skip 2
	.ROOM_TIME_S_DISPLAY: skip 2
	.ROOM_TIME_LAG_DISPLAY: skip 2
	.ROOM_TIME_IDLE_DISPLAY: skip 2

	.SEG_TIME_F_DISPLAY: skip 2
	.SEG_TIME_S_DISPLAY: skip 2
	.SEG_TIME_M_DISPLAY: skip 2

	.TIMER_FLAG: skip 2
	.SHORTCUT_USED: skip 2
endstruct













org $00F7E1
SA1Reset00:
	JML SA1Reset

SA1NMI00:
	JML SA1NMI

SA1IRQ00:
	JML SA1IRQ

incsrc sa1hud.asm
incsrc sa1sram.asm

pullpc
InitSA1:
	REP #$20

	LDA #$0020
	STA.w $2200

	LDA.w #SA1Reset00
	STA.w $2203

	LDA.w #SA1NMI00
	STA.w $2205

	LDA.w #SA1IRQ00
	STA.w $2207

	SEP #$20
	STZ $2200

	SEP #$30
	LDA.b #$81
	STA.w NMITIMEN
	RTL

CacheSA1Stuff:
	LDX.w $10 : STX.w SA1IRAM.CopyOf_10
	LDA.w $12 : STA.w SA1IRAM.CopyOf_12
	LDX.w $1A : STX.w SA1IRAM.CopyOf_1A
	LDX.w $20 : STX.w SA1IRAM.CopyOf_20
	LDX.w $22 : STX.w SA1IRAM.CopyOf_22
	LDX.w $24 : STX.w SA1IRAM.CopyOf_24
	LDX.w $27 : STX.w SA1IRAM.CopyOf_27
	LDA.w $29 : STA.w SA1IRAM.CopyOf_29
	LDX.w $2A : STX.w SA1IRAM.CopyOf_2A
	LDX.w $30 : STX.w SA1IRAM.CopyOf_30
	LDA.w $5B : STA.w SA1IRAM.CopyOf_5B
	LDX.w $5D : STX.w SA1IRAM.CopyOf_5D
	LDA.w $6C : STA.w SA1IRAM.CopyOf_6C
	LDX.w $A0 : STX.w SA1IRAM.CopyOf_A0
	LDX.w $A6 : STX.w SA1IRAM.CopyOf_A6
	LDX.w $A8 : STX.w SA1IRAM.CopyOf_A8
	LDA.w $AA : STA.w SA1IRAM.CopyOf_AA
	LDX.w $E2 : STX.w SA1IRAM.CopyOf_E2
	LDX.w $E8 : STX.w SA1IRAM.CopyOf_E8
	LDA.w $EE : STA.w SA1IRAM.CopyOf_EE
	LDA.w $F0 : STA.w SA1IRAM.CopyOf_F0
	LDA.w $F2 : STA.w SA1IRAM.CopyOf_F2
	LDA.w $F4 : STA.w SA1IRAM.CopyOf_F4
	LDA.w $F6 : STA.w SA1IRAM.CopyOf_F6
	LDX.w $0208 : STX.w SA1IRAM.CopyOf_0208
	LDA.w $020A : STA.w SA1IRAM.CopyOf_020A
	LDA.w $02A2 : STA.w SA1IRAM.CopyOf_02A2
	LDA.w $02FA : STA.w SA1IRAM.CopyOf_02FA
	LDX.w $0400 : STX.w SA1IRAM.CopyOf_0400
	LDX.w $0402 : STX.w SA1IRAM.CopyOf_0402
	LDA.w $0408 : STA.w SA1IRAM.CopyOf_0408
	LDA.w $040A : STA.w SA1IRAM.CopyOf_040A
	LDA.w $040C : STA.w SA1IRAM.CopyOf_040C
	LDX.w $0B08 : STX.w SA1IRAM.CopyOf_0B08

	LDA.w $7EF36C : STA.w SA1IRAM.CopyOf_7EF36C
	LDA.w $7EF36D : STA.w SA1IRAM.CopyOf_7EF36D
	RTL

SA1Reset:
	SEI
	CLC
	XCE
	REP #$38
	LDA #$0000
	PLD
	LDA #$37FF
	TCS

	PHK
	PLB

	LDA.w #$8180
	STA $2220
	STA $2222

	CLI

--	WAI
	BRA --

SA1NMI:
	SEI

	REP #$30
	PHA
	PHX
	PHY
	PHD
	PHB

	LDA.w #$3000
	TCD

	SEP #$30
	PHK
	PLB


	LDA.w $2301 ; get NMI type
	AND.b #$03
	ASL
	TAX

	JSR (.nmi_type, X)

	REP #$30
	PLB
	PLD
	PLY
	PLX
	PLA
	RTI

.nmi_nothing
	RTS

.nmi_type
	dw .nmi_nothing
	dw .nmi_shortcuts
	dw .nmi_timers
	dw .nmi_hud

.nmi_hud
	JSL draw_counters
	JSR hud_draw_hearts
	RTS

.nmi_shortcuts
	STZ.w SA1IRAM.SHORTCUT_USED+0
	STZ.w SA1IRAM.SHORTCUT_USED+1
	JSR check_mode_safety

	BEQ .safeForNone
	BVS .safeForAll
	BMI .safeForSome

.pracMenu
	JSR gamemode_shortcuts_practiceMenu
	BRA ++

.safeForSome
.safeForAll
	JSR gamemode_shortcuts_everything ; overflow flag checks the presets in here
	BCS .skip

.safeForNone

; SA1IRAM.TIMER_FLAG bitfield:
; 7 - timers have been set and are awaiing a hud update
; 6 - reset timer
; 5
; 4
; 3
; 2 - Update without blocking further updates
; 1 - One update then no more
; 0 - 
.skip
++	RTS

.nmi_timers
	SEP #$28 ; a=8, BCD=on
	;LDA !lowram_last_frame_did_saveload : BEQ .update_counters
	;JMP .dont_update_counters

.update_counters
	; if $12 = 1, then we weren't done with game code
	; that means we're in a lag frame
	LDA.w SA1IRAM.CopyOf_12 : STA.w SA1IRAM.CopyOf_12_B : LSR

	REP #$20
	LDA.w SA1IRAM.ROOM_TIME_LAG : ADC #$0000 ; carry set from $12 being 1
	STA.w SA1IRAM.ROOM_TIME_LAG

	; cycle controlled room time
	SEP #$21 ; include carry
	LDA.w SA1IRAM.ROOM_TIME_F : ADC #$00
	CMP #$60
	BCS .rtF60

.rtFOK
	BCC ++ ; 3 cycles

.rtF60 ; 1 cycle for branch
	LDA #$00 ; 2 cycles

++	STA.w SA1IRAM.ROOM_TIME_F

	REP #$20 ; seconds have 3 digits
	LDA.w SA1IRAM.ROOM_TIME_S : ADC #$0000 ; increments by 1 if F>=60
	STA.w SA1IRAM.ROOM_TIME_S

	; cycle controlled segment time
	SEP #$21 ; include carry
	LDA.w SA1IRAM.SEG_TIME_F : ADC #$00
	CMP #$60
	BCS .stF60

.stFOK
	BCC ++ ; 3 cycles

.stF60 ; 1 cycle for branch
	LDA #$00 ; 2 cycles

++	STA SA1IRAM.SEG_TIME_F

	LDA SA1IRAM.SEG_TIME_S : ADC #$00 ; increments by 1 if F>=60
	CMP #$60
	BCS .stS60

.stSOK
	BCC ++ ; 3 cycles

.stS60 ; 1 cycle for branch
	LDA #$00 ; 2 cycles

++	STA SA1IRAM.SEG_TIME_S

	REP #$20
	LDA SA1IRAM.SEG_TIME_M : ADC #$0000 ; increments by 1 if S>=60
	STA SA1IRAM.SEG_TIME_M

.dont_update_counters
	CLD

	SEP #$20
	LDA.w SA1IRAM.TIMER_FLAG 
	BMI .donothing
	BEQ .donothing

	BIT.w SA1IRAM.TIMER_FLAG
	REP #$30

	LDA #$000F ; transferring 16 bytes
	LDX.w #SA1IRAM.ROOM_TIME_F+$0F
	LDY.w #SA1IRAM.ROOM_TIME_F_DISPLAY+$0F

	MVP $00,$00

	BVC .dontreset

	STZ.w SA1IRAM.ROOM_TIME_F+0
	STZ.w SA1IRAM.ROOM_TIME_F+2
	STZ.w SA1IRAM.ROOM_TIME_F+4
	STZ.w SA1IRAM.ROOM_TIME_F+6

.dontreset
	SEP #$30
	LDA #$80 : STA.w SA1IRAM.TIMER_FLAG

.donothing
++	RTS

macro test_shortcut(shortcut, func, leavecarry, dofunc)
+	LDA.w !ram_ctrl1 : AND <shortcut> : CMP <shortcut> : BNE +
	AND.l !ram_ctrl1_filtered : BEQ +
	if equal(<leavecarry>, 0)
		CLC
	endif

	if equal(<dofunc>, 1)
		JSR <func>
	else
		LDA.w #<func>
		STA.w SA1IRAM.SHORTCUT_USED
	endif
	RTS
endmacro

!notVerySafe = select(!FEATURE_SD2SNES, .SD2SNESBranch, .OtherBranch)
gamemode_shortcuts:
.practiceMenu
	LDA $B0
	%a16() ; this code is copyright Lui 2020
	BEQ !notVerySafe
-	CLC : RTS

.everything
	TAY
	LDA.w SA1IRAM.CONTROLLER_1_FILTERED : ORA.w SA1IRAM.CONTROLLER_1_FILTERED+1 : BEQ -
	TYA
	%a16()
	BMI !notVerySafe

	%test_shortcut(!pracmenu_shortcut, gamemode_custom_menu, 1, 0)

.SD2SNESBranch
	;------------------------------
	%test_shortcut(!ram_ctrl_load_last_preset, gamemode_load_previous_preset, 1, 0)
	%test_shortcut(!ram_ctrl_save_state, gamemode_savestate_save, 1, 0)
	%test_shortcut(!ram_ctrl_load_state, gamemode_savestate_load, 1, 0)

.OtherBranch
	;------------------------------
	%test_shortcut(!ram_ctrl_reset_segment_timer, gamemode_reset_segment_timer, 0, 1)
	%test_shortcut(!ram_ctrl_somaria_pits, gamemode_somaria_pits_wrapper, 0, 0)
	%test_shortcut(!ram_ctrl_fix_vram, gamemode_fix_vram, 0, 0)
	%test_shortcut(!ram_ctrl_fill_everything, gamemode_fill_everything, 0, 0)
	%test_shortcut(!ram_ctrl_toggle_oob, gamemode_oob, 0, 0)
	%test_shortcut(!ram_ctrl_skip_text, gamemode_skip_text, 0, 0)
	%test_shortcut(!ram_ctrl_disable_sprites, gamemode_disable_sprites, 0, 0)
;	%test_shortcut(!ram_ctrl_replay_last_movie, gamemode_replay_last_movie, 1)

+	CLC
--	RTS

; return values in P
!SOME_SAFE = $8080 ; some presets are not always safe = negative flag

!ALL_SAFE = $4040 ; everything is safe = overflow flag
!NONE_SAFE = $0000 ; all modes unsafe = zero flag
; zero flag off = practice menu special


check_mode_safety:
	LDA $10 : CMP #$0C : BNE .notCustomMenu
	CLV ; clear overflow
	LDA #$01 ; make sure N/Z flags are not set
.neverSafe
	RTS

.notCustomMenu
	ASL : TAX ; get index
	REP #%11100010 ; clear NVMZ for checks and for 16 bit accum
	LDA Module_safety, X
	BEQ .neverSafe ; staying in 16 bit A is fine here

	STA $00
	LDY $11 ; get submodule

	%a8()
	LDA ($00), Y ; get safety level of submodule
	STA $00 ; put it in $00
	LDA $7EC011 : BEQ .safe ; check mosaics

	LDA.b #!SOME_SAFE ; not safe
	RTS

.safe
	LDA $00 : BIT $00 ; bit test to set NVZ
	RTS

Module_safety:
	dw !SOME_SAFE ; Intro_safety
	dw !SOME_SAFE ; SelectFile_safety
	dw !SOME_SAFE ; CopyFile_safety
	dw !SOME_SAFE ; EraseFile_safety
	dw !SOME_SAFE ; NamePlayer_safety
	dw !SOME_SAFE ; LoadFile_safety
	dw !SOME_SAFE ; PreDungeon_safety
	dw Dungeon_safety
	dw !SOME_SAFE ; PreOverworld_safety
	dw Overworld_safety
	dw !SOME_SAFE ; PreOverworld_safety
	dw Overworld_safety
	dw !SOME_SAFE ; CustomMenu_safety ; unsafe, but custom behavior
	dw !SOME_SAFE ; Unknown1_safety
	dw Messaging_safety
	dw !SOME_SAFE ; CloseSpotlight_safety
	dw !SOME_SAFE ; OpenSpotlight_safety
	dw !SOME_SAFE ; HoleToDungeon_safety
	dw !SOME_SAFE ; Death_safety
	dw !ALL_SAFE ; BossVictory_safety
	dw !SOME_SAFE ; Attract_safety
	dw !ALL_SAFE ; Mirror_safety
	dw !ALL_SAFE ; Victory_safety
	dw !SOME_SAFE ; Quit_safety
	dw !ALL_SAFE ; GanonEmerges_safety
	dw !SOME_SAFE ; TriforceRoom_safety
	dw !SOME_SAFE ;  EndSequence_safety
	dw !SOME_SAFE ; LocationMenu_safety

; How to behave on modules, pre shifted for address jumps

	Dungeon_safety: ; $07
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x00, 0x01, 0x02, 0x03
		db !ALL_SAFE, !ALL_SAFE, !SOME_SAFE, !SOME_SAFE ; 0x04, 0x05, 0x06, 0x07
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x08, 0x09, 0x0A, 0x0B
		db !ALL_SAFE, !ALL_SAFE, !SOME_SAFE, !SOME_SAFE ; 0x0C, 0x0D, 0x0E, 0x0F
		db !ALL_SAFE, !ALL_SAFE, !SOME_SAFE, !SOME_SAFE ; 0x10, 0x11, 0x12, 0x13
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x14, 0x15, 0x16, 0x17
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x18, 0x19, 0x1A

	Overworld_safety: ; $09/$0B
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x00, 0x01, 0x02, 0x03
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x04, 0x05, 0x06, 0x07
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x08, 0x09, 0x0A, 0x0B
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x0C, 0x0D, 0x0E, 0x0F
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x10, 0x11, 0x12, 0x13
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x14, 0x15, 0x16, 0x17
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x18, 0x19, 0x1A, 0x1B
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x1C, 0x1D, 0x1E, 0x1F
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !SOME_SAFE; 0x20, 0x21, 0x22, 0x23
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x24, 0x25, 0x26, 0x27
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x28, 0x29, 0x2A, 0x2B
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x2C, 0x2D, 0x2E, 0x2F

	Messaging_safety: ; $0E
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !NONE_SAFE ; 0x00, 0x01, 0x02, 0x03
		db !ALL_SAFE, !ALL_SAFE, !ALL_SAFE, !NONE_SAFE ; 0x04, 0x05, 0x06, 0x07
		db !ALL_SAFE, !NONE_SAFE, !ALL_SAFE, !ALL_SAFE ; 0x08, 0x09, 0x0A, 0x0B
	





SA1IRQ:


















