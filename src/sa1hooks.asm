pushpc
org $008000
struct SA1IRAM $003000
	.SCRATCH: skip 16

	.HDMA_ASK: skip 1
	.SHORTCUT_USED: skip 2

	.CONTROLLER_1:
	.CopyOf_F2: skip 1
	.CopyOf_F0: skip 1

	.CONTROLLER_1_FILTERED:
	.CopyOf_F6: skip 1
	.CopyOf_F4: skip 1

	.cm_submodule: skip 2
	.cm_cursor: skip 1 ; keep these together
	.cm_current_menu: skip 4
	.cm_select_current: skip 4
	.cm_select_draw: skip 4
	.cm_select_address: skip 4
	.cm_select_params:
	.cm_draw_color: skip 2
	.cm_draw_type_offset: skip 2
	.cm_draw_filler: skip 2

	; these can be shared because they're never used at the same time
	.cm_writer:
	.cm_leftright: skip 1 ; N=left V=right
	.cm_updown: skip 1 ; N=up V=down
	.cm_shoulder: skip 1 ; N=l V=r
	.cm_ax: skip 1 ; N=A V=X

	.cm_writer_args: skip 2

.savethis_start
	.TIMER_FLAG: skip 2

.timers_start
	.ROOM_TIME_F: skip 2
	.ROOM_TIME_S: skip 2
	.ROOM_TIME_LAG: skip 2
	.ROOM_TIME_IDLE: skip 2

	.SEG_TIME_F: skip 2
	.SEG_TIME_S: skip 2
	.SEG_TIME_M: skip 2
.timers_end

	.ROOM_TIME_F_DISPLAY: skip 2
	.ROOM_TIME_S_DISPLAY: skip 2
	.ROOM_TIME_LAG_DISPLAY: skip 2
	.ROOM_TIME_IDLE_DISPLAY: skip 2

	.SEG_TIME_F_DISPLAY: skip 2
	.SEG_TIME_S_DISPLAY: skip 2
	.SEG_TIME_M_DISPLAY: skip 2

	.CopyOf_10: skip 1
	.CopyOf_11: skip 1
	.CopyOf_12: skip 1
	.CopyOf_1A: skip 1
	.CopyOf_1B: skip 1
	.CopyOf_20: skip 1
	.CopyOf_21: skip 1
	.CopyOf_22: skip 1
	.CopyOf_23: skip 1
	.CopyOf_2A: skip 1
	.CopyOf_2B: skip 1
	.CopyOf_30: skip 1
	.CopyOf_31: skip 1
	.CopyOf_6C: skip 1
	.CopyOf_A0: skip 1
	.CopyOf_A1: skip 1
	.CopyOf_A4: skip 1
	.CopyOf_A5: skip 1
	.CopyOf_B0: skip 1
	.CopyOf_E2: skip 1
	.CopyOf_E3: skip 1
	.CopyOf_E8: skip 1
	.CopyOf_E9: skip 1
	.CopyOf_EE: skip 1

	.CopyOf_04A0: skip 1
	.CopyOf_04B4: skip 1

	.CopyOf_02A2: skip 1
	.CopyOf_02FA: skip 1

	.CopyOf_0B08: skip 1
	.CopyOf_0B09: skip 1

	.CopyOf_7EC011: skip 1
	.CopyOf_7EF36C: skip 1
	.CopyOf_7EF36D: skip 1

	; not copied, but just moved in rom
	.Moved_0208: skip 1
	.Moved_0209: skip 1
	.Moved_020A: skip 1

	; extra stuff
	.LanmoCycles: skip 16 ; 16 to be safe

.savethis_end
	print "SA1 dp: ", pc

	; ancilla watch
	.CopyOf_03C4: skip 1
	.CopyOf_03A4: skip 1
	.CopyOf_0C4A: skip 10
	.CopyOf_0C5E: skip 10

	.CopyOf_0BFA: skip 10
	.CopyOf_0C04: skip 10
	.CopyOf_0C0E: skip 10
	.CopyOf_0C18: skip 10

	; dg watch
	.CopyOf_A6: skip 1
	.CopyOf_A7: skip 1
	.CopyOf_A8: skip 1
	.CopyOf_A9: skip 1
	.CopyOf_AA: skip 1

	.CopyOf_0400: skip 1
	.CopyOf_0401: skip 1
	.CopyOf_0402: skip 1
	.CopyOf_0403: skip 1
	.CopyOf_0408: skip 1
	.CopyOf_040A: skip 1
	.CopyOf_040C: skip 1
	.CopyOf_04BA: skip 1
	.CopyOf_04BB: skip 1


	.CopyOf_068E: skip 1
	.CopyOf_068F: skip 1
	.CopyOf_0690: skip 1
	.CopyOf_0691: skip 1

	.CopyOf_7EC000: skip 1

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

	print "SA1 mirroring: ", pc
endstruct

;==============================================================================

org $00F7E1
SA1Reset00:
	JML SA1Reset

SA1NMI00:
	JML SA1NMI

SA1IRQ00:
	JML SA1IRQ

SNES_CUSTOM_NMI_BOUNCE:
	JML SNES_CUSTOM_NMI

warnpc $00F800

org $00FFB7 ; this barely fits
ReadJoyPad_long:
--	LSR.w $4212
	BCS --
	JSR.w $0083D1
	RTL

incsrc sa1hud.asm
incsrc sa1sram.asm

pullpc
CacheSA1Stuff:
	LDX.b $10 : STX.w SA1IRAM.CopyOf_10
	LDX.b $1A : STX.w SA1IRAM.CopyOf_1A
	LDX.b $20 : STX.w SA1IRAM.CopyOf_20
	LDX.b $22 : STX.w SA1IRAM.CopyOf_22
	LDX.b $2A : STX.w SA1IRAM.CopyOf_2A
	LDX.b $30 : STX.w SA1IRAM.CopyOf_30
	LDA.b $6C : STA.w SA1IRAM.CopyOf_6C
	LDX.b $A0 : STX.w SA1IRAM.CopyOf_A0
	LDX.b $A4 : STX.w SA1IRAM.CopyOf_A4

	LDA.b $B0 : STA.w SA1IRAM.CopyOf_B0
	LDX.b $E2 : STX.w SA1IRAM.CopyOf_E2
	LDX.b $E8 : STX.w SA1IRAM.CopyOf_E8
	LDA.b $EE : STA.w SA1IRAM.CopyOf_EE
	LDA.b $F0 : STA.w SA1IRAM.CopyOf_F0
	LDA.b $F2 : STA.w SA1IRAM.CopyOf_F2
	LDA.b $F4 : STA.w SA1IRAM.CopyOf_F4
	LDA.b $F6 : STA.w SA1IRAM.CopyOf_F6
	LDA.w $02A2 : STA.w SA1IRAM.CopyOf_02A2
	LDA.w $02FA : STA.w SA1IRAM.CopyOf_02FA
	LDA.w $04A0 : STA.w SA1IRAM.CopyOf_04A0
	LDX.w $0B08 : STX.w SA1IRAM.CopyOf_0B08
	LDA.w $04B4 : STA.w SA1IRAM.CopyOf_04B4

	LDA.l $7EC011 : STA.w SA1IRAM.CopyOf_7EC011
	LDA.l $7EF36C : STA.w SA1IRAM.CopyOf_7EF36C
	LDA.l $7EF36D : STA.w SA1IRAM.CopyOf_7EF36D

	; don't want to be transferring too much
	; certain things will get designated as slow
	LDA.b !ram_extra_sa1_required
	BEQ .noextra

	PHP
	JSR Extra_SA1_Transfers
	PLP

.noextra
	LDA.b #$81
	STA.w $2200
	RTL

Extra_SA1_Transfers:
	LDA.l !ram_superwatch
	ASL
	TAX
	SEP #$30
	JSR (.superwatchtransfers, X)

	RTS

.superwatchtransfers
	dw ..off
	dw ..ancillae
	dw ..uw
	dw ..off

..ancillae
	LDA.w $03C4 : STA.w SA1IRAM.CopyOf_03C4
	LDA.w $03A4 : STA.w SA1IRAM.CopyOf_03A4

	LDX.b #$09
--	LDA.w $0C4A, X : STA.w SA1IRAM.CopyOf_0C4A, X
	LDA.w $0C5E, X : STA.w SA1IRAM.CopyOf_0C5E, X
	DEX
	BPL --

..off
	RTS

..uw
	REP #$20
	LDA.b $A6 : STA.w SA1IRAM.CopyOf_A6
	LDA.b $A8 : STA.w SA1IRAM.CopyOf_A8
	LDX.b $AA : STX.w SA1IRAM.CopyOf_AA
	
	LDA.w $0400 : STA.w SA1IRAM.CopyOf_0400
	LDA.w $0402 : STA.w SA1IRAM.CopyOf_0402
	LDX.w $0408 : STX.w SA1IRAM.CopyOf_0408
	LDX.w $040A : STX.w SA1IRAM.CopyOf_040A
	LDX.w $040C : STX.w SA1IRAM.CopyOf_040C
	LDA.w $04BA : STA.w SA1IRAM.CopyOf_04BA
	LDA.w $068E : STA.w SA1IRAM.CopyOf_068E
	LDA.w $0690 : STA.w SA1IRAM.CopyOf_0690

	LDA.l $7EC000 : TAX : STX.w SA1IRAM.CopyOf_7EC000

	LDX.b #$1E
--	LDA.w $0600, X : STA.w SA1IRAM.CopyOf_0600, X
	DEX
	DEX
	BPL --

	RTS

;==============================================================================
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

	LDA.w #$8180
	STA.w $2220
	STA.w $2222

	SEP #$20
	LDA #$80
	STA.w $2226

	LDA.b #$03
	STA.w $2224

	LDA #$FF
	STA.w $2202
	STA.w $2229
	STZ.w $2228

	REP #$20
	STZ.b $F0
	STZ.b $F2
	STZ.b $F4
	STZ.b $F6
	STZ.w SA1IRAM.CopyOf_F0
	STZ.w SA1IRAM.CopyOf_F2
	STZ.w SA1IRAM.CopyOf_F4
	STZ.w SA1IRAM.CopyOf_F6

	STZ.w SA1IRAM.SHORTCUT_USED
	STZ.w $2200

	SEP #$30
	LDA.b #$81
	STA.w $4200
	RTL

SA1Reset:
	SEI
	CLC
	XCE

	REP #$FB

	LDA #$0000
	TCD
	STA.l !SAC_stating

	LDA #$37FF
	TCS

	PHK
	PLB

	LDA.w #SNES_CUSTOM_NMI_BOUNCE ; set up custom NMI vector
	STA.w $220C

	SEP #$30
	STZ.w $2209 ; but don't use it
	STZ.w $2210

	STZ.w $2230
	STZ.w $2231

	LDA.b #$80
	STA.w $2227

	LDA.b #$03
	STA.w $2225 ; image 3 for page $60

	LDA.b #$FF
	STA.w $222A

	LDA.b #$F0
	STA.w $220B

	LDA.b #$90
	STA.w $220A

	REP #$34
	LDX.w #(SA1RAM.end_of_clearable_sa1ram-SA1RAM.clearable_sa1ram)-1

--	STZ.w SA1RAM.clearable_sa1ram, X
	DEX
	DEX
	BPL --

--	BRA --

; SA1IRAM.TIMER_FLAG bitfield:
; 7 - timers have been set and are awaiting a hud update
; 6 - reset timer
; 5
; 4
; 3
; 2 - Update without blocking further updates
; 1 - One update then no more
; 0 - 
SA1NMI:
	REP #$30
	PHA
	PHX
	PHY
	PHD
	PHB

	SEP #$30
	LDA.b #$10
	STA.l $00220B

	PHK
	PLB

	LDA.w $2301
	AND.b #$03
	ASL
	TAX


	JSR.w (.nmis, X)

#SA1NMI_EXIT:
	REP #$30
	PLB
	PLD
	PLY
	PLX
	PLA
	RTI

.nmis
	dw .disable_custom_nmi
	dw .enable_custom_nmi
	dw SA1NMI_COUNTERS
	dw .nothing_at_all

.disable_custom_nmi
	STZ.w $2209

.nothing_at_all
	RTS

.enable_custom_nmi
	LDA.b #$10
	STA.w $2209
	RTS

SA1NMI_COUNTERS:
	SED

	;LDA.w SA1RAM.last_frame_did_saveload : BEQ .update_counters
	;JMP .dont_update_counters

.update_counters
	; if $12 = 1, then we weren't done with game code
	; that means we're in a lag frame
	LDA.b SA1IRAM.CopyOf_12 ; STA.b SA1IRAM.CopyOf_12_B
	LSR
	REP #$20
	LDA.b SA1IRAM.ROOM_TIME_LAG : ADC.w #$0000 ; carry set from $12 being 1
	STA.b SA1IRAM.ROOM_TIME_LAG

	SEP #$21 ; include carry so we can do +0+1
	LDA.b SA1IRAM.ROOM_TIME_F : ADC.b #$00
	CMP.b #$60
	BCC .rtFOK

.rtF60
	LDA.b #$00

.rtFOK
	STA.b SA1IRAM.ROOM_TIME_F

	REP #$20 ; seconds have 3 digits
	LDA.b SA1IRAM.ROOM_TIME_S : ADC.w #$0000 ; increments by 1 if F>=60
	STA.b SA1IRAM.ROOM_TIME_S

	SEP #$21 ; include carry
	LDA.b SA1IRAM.SEG_TIME_F : ADC.b #$00
	CMP.b #$60
	BCC .stFOK

.stF60
	LDA.b #$00

.stFOK
	STA.b SA1IRAM.SEG_TIME_F

	LDA.b SA1IRAM.SEG_TIME_S : ADC.b #$00 ; increments by 1 if F>=60
	CMP.b #$60
	BCC .stSOK

.stS60
	LDA.b #$00

.stSOK
	STA.b SA1IRAM.SEG_TIME_S

	REP #$20
	LDA.b SA1IRAM.SEG_TIME_M : ADC #$0000 ; increments by 1 if S>=60
	STA.b SA1IRAM.SEG_TIME_M

.dont_update_counters
	CLD

	SEP #$20
	LDA.b SA1IRAM.TIMER_FLAG 
	BMI .donothing
	BEQ .donothing

	BIT.b SA1IRAM.TIMER_FLAG
	REP #$30

	LDA.w #SA1IRAM.timers_end-SA1IRAM.timers_start-1

	LDX.w #SA1IRAM.ROOM_TIME_F
	LDY.w #SA1IRAM.ROOM_TIME_F_DISPLAY

	MVN $00,$00

	BVC .dontreset

	STZ.b SA1IRAM.ROOM_TIME_F+0
	STZ.b SA1IRAM.ROOM_TIME_F+2
	STZ.b SA1IRAM.ROOM_TIME_F+4
	STZ.b SA1IRAM.ROOM_TIME_F+6

.dontreset
	SEP #$30
	LDA #$80
	STA.b SA1IRAM.TIMER_FLAG

.donothing
++	RTS

; For everything not a timer
SA1IRQ:
	SEI

	REP #$30
	PHA
	PHX
	PHY
	PHD
	PHB

	SEP #$30

	LDA.b #$80
	STA.l $00220B

	PHK
	PLB

	LDA.w $2301 ; get IRQ type
	AND.b #$03
	ASL
	TAX

	JSR (.irq_type, X)

	REP #$30
	PLB
	PLD
	PLY
	PLX
	PLA
	RTI

.irq_nothing
	RTS

.irq_type
	dw .irq_nothing
	dw .irq_shortcuts
	dw .irq_nothing
	dw .irq_hud

	dw .irq_nothing
	dw .irq_nothing
	dw .irq_nothing
	dw .irq_nothing

.irq_hud
	JSL draw_hud_extras
	RTS

.irq_shortcuts
	JSR check_mode_safety

	BEQ gamemode_shortcuts_nothing    ; safeForNone
	BVS gamemode_shortcuts_everything ; safeForAll
	BMI gamemode_shortcuts_everything ; safeForSome

gamemode_shortcuts:
.practiceMenu
	LDA.b SA1IRAM.CopyOf_B0
	REP #$20 ; this code is copyright Lui 2020
	BEQ .pracmenu_allowed
.nothing
	RTS

.everything
	TAY
	LDA.b SA1IRAM.CONTROLLER_1_FILTERED
	ORA.b SA1IRAM.CONTROLLER_1_FILTERED+1 : BEQ .nothing

	REP #$10
	LDX.w #0
	TYA
	BPL .pracmenu_allowed

	LDX.w #4

.pracmenu_allowed
	REP #$20

.nextcheck
	LDA.w .shortcut_routine, X
	BEQ ..nothingused

	STA.b SA1IRAM.SCRATCH+0
	LDA.b (SA1IRAM.SCRATCH+0)

	AND.b SA1IRAM.CONTROLLER_1
	CMP.b (SA1IRAM.SCRATCH+0)
	BNE ..fail

	AND.b SA1IRAM.CONTROLLER_1_FILTERED
	BEQ ..fail

	LDA.w .shortcut_routine+2, X
	BPL ..forsnes

..forsa1
	JSL UseShortCutSA1
	RTS

..forsnes
	ORA.w #$8000 ; add in bit 7 that was used as a flag in rom table
	STA.b SA1IRAM.SHORTCUT_USED

..nothingused
	RTS

..fail
	INX
	INX
	INX
	INX
	BRA .nextcheck

!CPU_SIDE = $7FFF ; for routines to be done by the SNES CPU
!SA1_SIDE = $FFFF ; for routines to be done by the SA1 instead of the CPU

.shortcut_routine
	dw ..pracmenushortcut, gamemode_custom_menu&!CPU_SIDE
	dw !ram_ctrl_load_last_preset, gamemode_load_previous_preset&!CPU_SIDE
	dw !ram_ctrl_save_state, gamemode_savestate_save&!CPU_SIDE
	dw !ram_ctrl_load_state, gamemode_savestate_load&!CPU_SIDE
	dw !ram_ctrl_reset_segment_timer, gamemode_reset_segment_timer&!SA1_SIDE
	dw !ram_ctrl_somaria_pits, gamemode_somaria_pits_wrapper&!CPU_SIDE
	dw !ram_ctrl_fix_vram, gamemode_fix_vram&!CPU_SIDE
	dw !ram_ctrl_fill_everything, gamemode_fill_everything&!CPU_SIDE
	dw !ram_ctrl_toggle_oob, gamemode_oob&!CPU_SIDE
	dw !ram_ctrl_skip_text, gamemode_skip_text&!CPU_SIDE
	dw !ram_ctrl_disable_sprites, gamemode_disable_sprites&!CPU_SIDE
	dw 0, 0

#final_static_short_PracMenuShortcut:
..pracmenushortcut
	dw $1010

; return values in P
!SOME_SAFE = $8080 ; some options are not always safe = negative flag
!ALL_SAFE = $4040 ; everything is safe = overflow flag
!NONE_SAFE = $0000 ; all modes unsafe = zero flag
; zero flag off = practice menu special

check_mode_safety:
	LDA.b SA1IRAM.CopyOf_10 : CMP.b #$0C : BNE .notCustomMenu
	REP #%11000010 ; clear NVZ
.neverSafe
	RTS

.notCustomMenu
	ASL : TAX ; get index
	REP #%01100000 ; clear V for checks and M for 16 bit accum
	LDA.w Module_safety, X
	BEQ .neverSafe ; staying in 16 bit A is fine here

	STA.b SA1IRAM.SCRATCH
	LDY.b SA1IRAM.CopyOf_11 ; get submodule

	SEP #$20
	LDA.b (SA1IRAM.SCRATCH), Y ; get safety level of submodule
	STA.b SA1IRAM.SCRATCH ; put it in $00
	LDY.b SA1IRAM.CopyOf_7EC011 : BEQ .safe ; check mosaics

	LDA.b #!SOME_SAFE ; not safe
	RTS

.safe
	BIT.b SA1IRAM.SCRATCH ; bit test to set NVZ
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
