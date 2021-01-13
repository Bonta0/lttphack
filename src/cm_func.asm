CMDO_SAVE_ADDRESS_LONG:
	JSR .continue

	LDA.b [SA1IRAM.cm_current_selection], Y
	STA.b SA1IRAM.cm_writer+2
	INY
	RTS

#CMDO_SAVE_ADDRESS_00:
	SEP #$20
	STZ.b SA1IRAM.cm_writer+2

.continue
	REP #$20
	LDA.b [SA1IRAM.cm_current_selection], Y
	INY
	INY

	STA.b SA1IRAM.cm_writer+0

	SEP #$20

ACTION_EXIT:
CMDO_HEADER:
	RTS

;===============================================================================

CMDO_TOGGLE_BIT0:
CMDO_TOGGLE_BIT0_CUSTOMTEXT:
	LDA.b #$1<<0 : BRA CMDO_TOGGLE_BIT_LOCAL

CMDO_TOGGLE_BIT1:
CMDO_TOGGLE_BIT1_CUSTOMTEXT:
	LDA.b #$1<<1 : BRA CMDO_TOGGLE_BIT_LOCAL

CMDO_TOGGLE_BIT2:
CMDO_TOGGLE_BIT2_CUSTOMTEXT:
	LDA.b #$1<<2 : BRA CMDO_TOGGLE_BIT_LOCAL

CMDO_TOGGLE_BIT3:
CMDO_TOGGLE_BIT3_CUSTOMTEXT:
	LDA.b #$1<<3 : BRA CMDO_TOGGLE_BIT_LOCAL

CMDO_TOGGLE_BIT4:
CMDO_TOGGLE_BIT4_CUSTOMTEXT:
	LDA.b #$1<<4 : BRA CMDO_TOGGLE_BIT_LOCAL

CMDO_TOGGLE_BIT5:
CMDO_TOGGLE_BIT5_CUSTOMTEXT:
	LDA.b #$1<<5 : BRA CMDO_TOGGLE_BIT_LOCAL

CMDO_TOGGLE_BIT6:
CMDO_TOGGLE_BIT6_CUSTOMTEXT:
	LDA.b #$1<<6 : BRA CMDO_TOGGLE_BIT_LOCAL

CMDO_TOGGLE_BIT7:
CMDO_TOGGLE_BIT7_CUSTOMTEXT:
	LDA.b #$1<<7 : BRA CMDO_TOGGLE_BIT_LOCAL

CMDO_TOGGLE_BIT_LONG:
	PHA
	JSR CMDO_SAVE_ADDRESS_LONG
	BRA .continue

#CMDO_TOGGLE_BIT_LOCAL:
	PHA
	JSR CMDO_SAVE_ADDRESS_00

.continue
	PLA
	BIT.b SA1IRAM.cm_ax
	BMI .toggle
	BVS .clear

	BIT.b SA1IRAM.cm_leftright
	BMI .toggle
	BVS .toggle

	BIT.b SA1IRAM.cm_y
	BMI .enable

	CLC
	RTS

.clear
	EOR.b #$FF ; get complement for the AND
	STZ.b SA1IRAM.cm_writer_args+0 ; EOR in nothing
	JSL CM_MenuSFX_empty
	BRA CMDO_TOGGLE_SAVE_A

.enable
	STA.b SA1IRAM.cm_writer_args+0 ; EOR will toggle but
	STA.b SA1IRAM.cm_writer_args+2 ; it also gets ORA'd in

	JSL CM_MenuSFX_fill
	BRA CMDO_TOGGLE_SAVE_B

.toggle
	STA.b SA1IRAM.cm_writer_args+0

	LDA.b #$FF
	BRA CMDO_TOGGLE_SAVE_A

CMDO_TOGGLE_BIT7_LONG:
CMDO_TOGGLE_BIT7_LONG_CUSTOMTEXT:
	LDA.b #$1<<7 : BRA CMDO_TOGGLE_BIT_LONG

CMDO_TOGGLE_BIT6_LONG:
CMDO_TOGGLE_BIT6_LONG_CUSTOMTEXT:
	LDA.b #$1<<6 : BRA CMDO_TOGGLE_BIT_LONG

CMDO_TOGGLE_BIT5_LONG:
CMDO_TOGGLE_BIT5_LONG_CUSTOMTEXT:
	LDA.b #$1<<5 : BRA CMDO_TOGGLE_BIT_LONG

CMDO_TOGGLE_BIT4_LONG:
CMDO_TOGGLE_BIT4_LONG_CUSTOMTEXT:
	LDA.b #$1<<4 : BRA CMDO_TOGGLE_BIT_LONG

CMDO_TOGGLE_BIT3_LONG:
CMDO_TOGGLE_BIT3_LONG_CUSTOMTEXT:
	LDA.b #$1<<3 : BRA CMDO_TOGGLE_BIT_LONG

CMDO_TOGGLE_BIT2_LONG:
CMDO_TOGGLE_BIT2_LONG_CUSTOMTEXT:
	LDA.b #$1<<2 : BRA CMDO_TOGGLE_BIT_LONG

CMDO_TOGGLE_BIT1_LONG:
CMDO_TOGGLE_BIT1_LONG_CUSTOMTEXT:
	LDA.b #$1<<1 : BRA CMDO_TOGGLE_BIT_LONG

CMDO_TOGGLE_BIT0_LONG:
CMDO_TOGGLE_BIT0_LONG_CUSTOMTEXT:
	LDA.b #$1<<0 : BRA CMDO_TOGGLE_BIT_LONG

CMDO_TOGGLE_LONG:
	JSR CMDO_SAVE_ADDRESS_LONG
	BRA .continue

#CMDO_TOGGLE:
	JSR CMDO_SAVE_ADDRESS_00

.continue
	SEP #$20

	LDA.b #$01
	STA.b SA1IRAM.cm_writer_args+0

	BIT.b SA1IRAM.cm_ax
	BVS .clear
	BMI .toggle

	BIT.b SA1IRAM.cm_leftright
	BMI .toggle
	BVS .toggle

	BIT.b SA1IRAM.cm_y
	BMI .enable

	CLC
	RTS

.toggle
#CMDO_TOGGLE_SAVE_A:
	STZ.b SA1IRAM.cm_writer_args+2

#CMDO_TOGGLE_SAVE_B:
	STA.b SA1IRAM.cm_writer_args+1

#CMDO_PERFORM_TOGGLE:
	SEC ; set the carry here, since that means something happened

	LDA.b [SA1IRAM.cm_writer]
	EOR.b SA1IRAM.cm_writer_args+0
	AND.b SA1IRAM.cm_writer_args+1
	ORA.b SA1IRAM.cm_writer_args+2
	STA.b [SA1IRAM.cm_writer]

	JSL CM_MenuSFX_bink
	RTS

.clear
	JSL CM_MenuSFX_empty
	LDA.b #$00
	BRA CMDO_TOGGLE_SAVE_A

.enable
	STA.b SA1IRAM.cm_writer_args+2
	JSL CM_MenuSFX_fill
	BRA CMDO_TOGGLE_SAVE_B

;===============================================================================
CMDO_TOGGLE_FUNC:
CMDO_TOGGLE_FUNC_CUSTOMTEXT:
	JSR CMDO_TOGGLE
	BRA CMDO_PERFORM_FUNC

CMDO_TOGGLE_LONG_FUNC:
CMDO_TOGGLE_LONG_FUNC_CUSTOMTEXT:
	JSR CMDO_TOGGLE_LONG
	BRA CMDO_PERFORM_FUNC

CMDO_FUNC_FILTERED:
	PHD

	PEA.w $0000
	PLD

	JSR CMDO_FUNC

	SEP #$20
	STZ.b $15

	PLD

	RTS

; jump here for anything with an attached function
; expects Y to point to the current function argument
; carry means a function should happen
CMDO_FUNC:
	LDA.b SA1IRAM.cm_ax ; get A press in carry
	ASL

#CMDO_PERFORM_FUNC:
	BCC .exit

	JSR CMDO_SAVE_ADDRESS_LONG
	PHK
	PEA.w .return-1

	SEP #$30
	JML.w [SA1IRAM.cm_writer]

.return
	SEC
	JSL CM_MenuSFX_switch

.exit
	RTS

CMDO_CHOICE_LONG_FUNC:
CMDO_CHOICE_LONG_FUNC_PRGTEXT:
	JSR CMDO_CHOICE_LONG
	INY
	INY
	INY
	BRA CMDO_PERFORM_FUNC

#CMDO_CHOICE_FUNC:
#CMDO_CHOICE_FUNC_PRGTEXT:
	JSR CMDO_CHOICE
	INY
	INY
	INY
	BRA CMDO_PERFORM_FUNC

CMDO_CHOICE_LONG_FUNC_FILTERED:
	JSR CMDO_CHOICE_LONG
	INY
	INY
	INY
	BRA CMDO_FUNC_FILTERED

;===============================================================================
CMDO_NUMFIELD_FUNC:
CMDO_NUMFIELD_FUNC_HEX:
CMDO_NUMFIELD_FUNC_PRGTEXT:
	JSR CMDO_NUMFIELD
	BRA CMDO_PERFORM_FUNC

CMDO_NUMFIELD_LONG_FUNC:
CMDO_NUMFIELD_LONG_FUNC_HEX:
CMDO_NUMFIELD_LONG_FUNC_PRGTEXT:
	JSR CMDO_NUMFIELD_LONG
	BRA CMDO_PERFORM_FUNC

;===============================================================================

CMDO_CHOICE_LONG:
CMDO_CHOICE_LONG_PRGTEXT:
	JSR CMDO_SAVE_ADDRESS_LONG
	BRA .continue

#CMDO_CHOICE:
#CMDO_CHOICE_PRGTEXT:
	JSR CMDO_SAVE_ADDRESS_00

.continue
	LDA.b [SA1IRAM.cm_writer]
	BIT.b SA1IRAM.cm_ax
	BVS .empty
	BMI .increment

	BIT.b SA1IRAM.cm_leftright
	BMI .decrement
	BVS .increment
	INY
	CLC ; carry clear = nothing actionable, so no functions
	RTS

.decrement
	CMP.b #$00
	BNE .not_max

	; the max value needs to be decremented too
	LDA.b [SA1IRAM.cm_current_selection], Y

.not_max
	DEC
	BRA .set

.increment
	INC
	CMP.b [SA1IRAM.cm_current_selection], Y
	BCC .set

.clear
	LDA.b #$00

.set
	STA.b [SA1IRAM.cm_writer]
	INY
	SEC ; carry set = actionable, so do functions
	JSL CM_MenuSFX_bink
	RTS

.empty
	JSL CM_MenuSFX_empty
	BRA .clear

;===============================================================================
CMDO_SUBMENU:
	BIT.b SA1IRAM.cm_ax
	BPL .no

	JSR EmptyCurrentMenu
	JSR CM_PushMenuToStack

	REP #$30
	LDA.b [SA1IRAM.cm_current_selection]
	AND.w #$FF00
	STA.b SA1IRAM.cm_cursor+0

	LDY.w #$02
	LDA.b [SA1IRAM.cm_current_selection], Y
	STA.b SA1IRAM.cm_cursor+2

.drawmenu
	JSR DrawCurrentMenu
	JSL NMI_RequestFullMenuUpdate

	JSR CM_UpdateCurrentSelection
	JSL CM_MenuSFX_submenu

.no
	RTS


#CMDO_SUBMENU_VARIABLE:
	BIT.b SA1IRAM.cm_ax
	BPL .no

	JSR EmptyCurrentMenu
	JSR CM_PushMenuToStack

	JSL CM_MenuSFX_submenu
	SEC

	LDY.w #1
	JSR CMDO_PERFORM_FUNC
	BRA .drawmenu

CMDO_PRESET_UW:
CMDO_PRESET_OW:
	BIT.b SA1IRAM.cm_ax
	BMI .go
	RTS

.go
	JSR CMDO_SAVE_ADDRESS_00

	REP #$20
	TXA
	STX.b SA1IRAM.preset_type

	LDA.b SA1IRAM.cm_writer+0
	STA.b SA1IRAM.preset_addr+0

	JSL CM_Exiting
	SEP #$30
	STZ.w $4200

	LDA.b SA1IRAM.cm_current_menu+2
	STA.b SA1IRAM.preset_addr+2

	LDA.b #$80
	STA.w $2100

	JML preset_load

CMDO_CTRL_SHORTCUT_FINAL:
	LDA.b SA1IRAM.cm_ax
	BIT.b #$C0
	BEQ .no

	JSL CM_MenuSFX_error
.no
	RTS

CMDO_CTRL_SHORTCUT:
	JSR CMDO_SAVE_ADDRESS_00

	LDA.b #$C0
	BIT.b SA1IRAM.cm_ax
	BEQ .no

	REP #$20
	STZ.b SA1IRAM.preset_scratch

	LDA.w #$0000
	STA.b [SA1IRAM.cm_writer]
	BVS .delete

	LDA.w #$0008
	STA.b SA1IRAM.cm_submodule
	JSL CM_MenuSFX_setshortcut
	RTS

.delete
	JSL CM_MenuSFX_empty

.no
	RTS



;===============================================================================
CMDO_NUMFIELD_PRESSFUNC_HEX:
	LDA.b SA1IRAM.cm_ax
	ASL
	BCC CMDO_NUMFIELD
	LDY.b #6
	JMP CMDO_PERFORM_FUNC


CMDO_NUMFIELD:
CMDO_NUMFIELD_HEX:
	JSR CMDO_SAVE_ADDRESS_00
	BRA .continue

#CMDO_NUMFIELD_LONG:
#CMDO_NUMFIELD_LONG_HEX:
#CMDO_NUMFIELD_LONG_2DIGITS:
	JSR CMDO_SAVE_ADDRESS_LONG

.continue
	LDA.b [SA1IRAM.cm_writer]
	BIT.b SA1IRAM.cm_ax
	BVS .delete

	; Y currently points to our minimum value
	BIT.b SA1IRAM.cm_y
	BMI .get_max_min

	BIT.b SA1IRAM.cm_leftright
	BMI .decrement

	INY ; Y now points to our maximum
	BVS .increment

	INY ; now point to slider size or whatever you wanna call it
	BIT.b SA1IRAM.cm_shoulder
	BMI .dec_big
	BVS .inc_big

	INY
	CLC
	RTS

.delete
	JSL CM_MenuSFX_empty
	BRA .clear_min

.topoff
	JSL CM_MenuSFX_fill
	BRA .get_max_min

.increment
	CMP.b [SA1IRAM.cm_current_selection], Y
	INC
	BCC .in_range_max

.clear_max
	DEY ; point to min

.clear_min
	LDA.b [SA1IRAM.cm_current_selection], Y

.in_range_min
	INY ; point to max

.in_range_max
	INY ; point to slide

.in_range_slide
.set
	STA.b [SA1IRAM.cm_writer]

	INY ; this should now point to after slide
	SEC
	JSL CM_MenuSFX_bink
	RTS

.decrement
	CMP.b #$00
	BEQ .get_max_min
	DEC

	; now our new value against the minimum
	CMP.b [SA1IRAM.cm_current_selection], Y
	INY ; point this to max, just in case we need it
	BCS .in_range_max
	BRA .get_max_max ; since we're already pointed there

.get_max_min
	INY

.get_max_max
	LDA.b [SA1IRAM.cm_current_selection], Y
	BRA .in_range_max

.dec_big ; also these shouldn't wrap on overflow
	SEC
	SBC.b [SA1IRAM.cm_current_selection], Y
	DEY ; pointing to max
	BCC .clear_max ; if we borrowed here, we need to floor ourselves

	DEY ; pointing to min
	CMP.b [SA1IRAM.cm_current_selection], Y
	BCS .in_range_min ; we're fine
	BRA .clear_min ; don't go past the minimum

.inc_big
	CLC
	ADC.b [SA1IRAM.cm_current_selection], Y
	DEY ; pointing to max
	BCS .get_max_max ; if we went too high, cap now

	CMP.b [SA1IRAM.cm_current_selection], Y
	BCS .get_max_max ; will cap if we match, but that's fine
	BRA .in_range_max