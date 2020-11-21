pushpc
org $008056 ; Game Mode Hijack
	JSL gamemode_hook
pullpc



gamemode_hook:
	LDA.l SA1IRAM.SHORTCUT_USED
	BEQ .askforshortcut

	REP #$20
	PHB
	PHK
	PLB
	PEA.w .ret-1

	JMP.w (SA1IRAM.SHORTCUT_USED)

.ret
	REP #$20
	STZ.w SA1IRAM.SHORTCUT_USED+0
	PLB
	RTL

.askforshortcut
	LDA #$81 : STA.l $002200 ; SA-1 NMI, bit 1 for preparing shortcut checks
	JML $0080B5 ; GameMode


	LDA !ram_lagometer_toggle : BEQ .done
	JSR gamemode_lagometer
.done
	RTL





; Custom Menu
gamemode_custom_menu:
	LDA $10 : STA !ram_cm_old_gamemode

	LDA #$000C : STA $10

	SEC : RTS


; Load previous preset
gamemode_load_previous_preset:
	%ai8()

	; Loading during text mode make the text stay or the item menu to bug
	LDA $10 : CMP #$0E : BEQ .no_load_preset
	%a16()
	LDA !ram_previous_preset_destination
	%a8()
	BEQ .no_load_preset

	STZ !lowram_is_poverty_load

	JSL preset_load_last_preset
	SEC : RTS

.no_load_preset
	CLC : RTS

; Replay last movie
gamemode_replay_last_movie:
	%a8()
	LDA !ram_movie_mode : CMP #$02 : BEQ .no_replay

	%ai8()
	JSR gamemode_load_previous_preset : BCC .no_replay
	LDA #$02 : STA !ram_movie_next_mode

	SEC : RTS

.no_replay
	%a8()
	CLC : RTS

; Save state
gamemode_savestate:
.save
if !FEATURE_SD2SNES
	%a8()
	%i16()
	; Remember which song bank was loaded before load stating
	; I put it here too, since `end` code runs both on save and load state..
	LDA $0136 : STA !sram_old_music_bank

	; store DMA to SRAM
	LDY #$0000 : LDX #$0000
-	LDA $4300, X : STA !sram_ss_dma_buffer, X
	INX
	INY : CPY #$000B : BNE -
	CPX #$007B : BEQ +
	INX #5
	LDY #$0000
	BRA -
	; end of DMA to SRAM

+	JSR ppuoff
	LDA #$80 : STA $4310
	JSR func_dma2

	LDA #$81 : STA $4310
	LDA #$39 : STA $4311
	JMP end

else

	; make sure we're not on a screen transition or falling down
	LDA $0126 : AND #$00FF : ORA $0410 : BNE .skip
	LDA $5B : AND #$00FF : CMP #$0002 : BCS .skip
	%a8()
	JSL save_preset_data
	%ai8()
	SEC : RTS

.skip
	%ai8()
	CLC : RTS

endif

.load
	%a8()
	%i16()
	; Remember which song bank was loaded before load stating (so we can change if needed)
	LDA $0136 : STA !sram_old_music_bank

	LDA !ram_rerandomize_toggle : BEQ .dont_rerandomize_1

	; Save the current framecounter & rng accumulator
	LDA $1A : STA !ram_rerandomize_framecount
	LDA $0FA1 : STA !ram_rerandomize_accumulator

.dont_rerandomize_1
if !FEATURE_SD2SNES

	%a8()
	; Mute music
	LDA #$F0 : STA $2140

	; Mute ambient sounds
	LDA #$05 : STA $2141

	STZ $420C
	JSR ppuoff
	STZ $4310
	JSR func_dma2

	LDX $1C : STX $212C
	LDX $1E : STX $212E
	LDX $94 : STX $2105
	LDX $96 : STX $2123
	LDX $99 : STX $2130

	INC $15
	LDA $0130 : STA $012C
	STZ $0133

	LDA $0131 : CMP #$17 : BEQ .annoyingSounds ; Bird music
	STA $012D : STZ $0131

.annoyingSounds
	LDA $0638 : STA $211F
	LDA $0639 : STA $211F
	LDA $063A : STA $2120
	LDA $063B : STA $2120
	LDA $98 : STA $2125
	LDA $9B : STA $420C

	LDA #$01 : STA $4310
	LDA #$18 : STA $4311

	LDA !ram_rerandomize_toggle : BEQ .dont_rerandomize_2

	LDA !ram_rerandomize_framecount : STA $1A
	LDA !ram_rerandomize_accumulator : STA $0FA1

.dont_rerandomize_2
	LDA.l !ram_framerule
	DEC
	BMI .nofixedframerule
	STA $1A

.nofixedframerule
+ %a8()
	JMP end

else
	%a8()
	; Loading during text mode makes the text stay or the item menu to bug
	LDA $10 : CMP #$0E : BEQ .no_load

	LDA !ram_can_load_pss : BEQ .no_load

	%a16()
	LDA #!sram_pss_offset+1 : STA !ram_preset_destination
	%a8()
	LDA !sram_pss_offset : STA !ram_preset_type
	LDA #12 : STA $10
	LDA #05 : STA $11
	LDA #$01 : STA !lowram_is_poverty_load

	%ai8()
	SEC : RTS

.no_load:
	%ai8()
	CLC : RTS

endif

ppuoff:
	LDA #$80 : STA $2100
	STZ $4200
	RTS

func_dma1:
	LDX #$7500 : LDY #$0000 : LDA #$80 : JSR func_dma1b
	LDX #$7600 : LDY #$4000 : LDA #$80 : JSR func_dma1b
	RTS

func_dma1b:
	STY $2116 : STZ $4312 : STX $4313 : STZ $4315 : STA $4316 : STZ $2115

	LDA $4311 : CMP #$39 : BNE +
	LDA $2139

+	LDA #$02 : STA $420B
	RTS

func_dma2:
	PLX : STX $4318

	STZ $2181 : STZ $4312

	LDY #$0071 : LDX #$0000 : JSR func_dma2b
	INY : LDX #$0080 : JSR func_dma2b
	INY : LDX #$0100 : JSR func_dma2b
	INY : LDX #$0180 : JSR func_dma2b

	LDX $4318 : PHX

	RTS

func_dma2b:
	STZ $4313 : STY $4314 : STX $2182
	LDA #$80 : STA $4311 : STA $4316
	LDA #$02 : STA $420B
	RTS

end:
	JSR func_dma1

	; load DMA from SRAM
	LDY #$0000 : LDX #$0000
	%a8()
	%i16()
-	LDA !sram_ss_dma_buffer, X : STA $4300, X
	INX
	INY : CPY #$000B : BNE -
	CPX #$007B : BEQ +
	INX #5
	LDY #$0000
	BRA -
	; end of DMA from SRAM

+	LDA !sram_old_music_bank : CMP $0136 : BEQ .songBankNotChanged
	JSL music_reload

.songBankNotChanged

	LDA #$81 : STA $4200
	LDA $13 : STA $2100
	%ai8()
	LDA #$01 : STA !lowram_last_frame_did_saveload
	SEC : RTS

after_save_state:
	%ai8()
	CLC : RTS


gamemode_oob:
	%a8()
	LDA !lowram_oob_toggle : EOR #$01 : STA !lowram_oob_toggle
	RTS


gamemode_skip_text:
	%a8()
	LDA #$04 : STA $1CD4
	RTS


gamemode_disable_sprites:
	%a8()
	JSL !Sprite_DisableAll
	RTS


; TODO make this a table instead of a bunch of STA?
gamemode_fill_everything_long:
	PHP
	JSR gamemode_fill_everything
	PLP
	RTL

gamemode_fill_everything:
	%a8()
	LDA #$01
	STA !ram_item_book
	STA !ram_item_hook
	STA !ram_item_fire_rod
	STA !ram_item_ice_rod
	STA !ram_item_bombos
	STA !ram_item_ether
	STA !ram_item_2quake
	STA !ram_item_lantern
	STA !ram_item_hammer
	STA !ram_item_net
	STA !ram_item_somaria
	STA !ram_item_byrna
	STA !ram_item_cape
	STA !ram_equipment_boots
	STA !ram_equipment_flippers
	STA !ram_equipment_moon_pearl
	STA !ram_equipment_half_magic

	LDA #$02
	STA !ram_item_boom
	STA !ram_item_mirror
	STA !ram_item_powder
	STA !ram_equipment_gloves
	STA !ram_equipment_shield
	STA !ram_equipment_armor

	LDA #$03
	STA !ram_item_bow
	STA !ram_item_bottle_array+0
	STA !ram_item_flute

	LDA #$04
	STA !ram_item_bottle_array+1
	STA !ram_equipment_sword

	LDA #$05
	STA !ram_item_bottle_array+2

	LDA #$06 : STA !ram_item_bottle_array+3

	LDA #$09 : STA !ram_equipment_keys
	LDA #20<<3 : STA !ram_equipment_maxhp
	LDA #19<<3 : STA !ram_equipment_curhp

	; rupees
	%a16() : LDA #$03E7 : STA $7EF360 : STA $7EF362 : %a8()

	LDA #$78
	STA !ram_equipment_magic_meter

	LDA #30
	STA !ram_item_bombs
	STA !ram_equipment_arrows_filler

	LDA #$FF
	STA !ram_capabilities

	SEP #$30
	JSL !DecompSwordGfx
	JSL !Palette_Sword
	JSL !DecompShieldGfx
	JSL !Palette_Shield
	JSL !Palette_Armor

	LDA !ram_game_progress : BNE .exit
	LDA #$01 : STA !ram_game_progress

.exit
	RTS

gamemode_reset_segment_timer:
	%a16()
	STZ.w SA1IRAM.SEG_TIME_F
	STZ.w SA1IRAM.SEG_TIME_S
	STZ.w SA1IRAM.SEG_TIME_M
	%a8()
	RTS

gamemode_fix_vram:
	%a16()
	%i16()
	LDA #$0280 : STA $2100
	LDA #$0313 : STA $2107
	LDA #$0063 : STA $2109 ; zeros out unused bg4
	LDA #$0722 : STA $210B
	STZ $2133 ; mode 7 register hit, but who cares

	%a8()
	LDA #$80 : STA $13 : STA $2100 ; keep fblank on while we do stuff
	LDA $1B : BEQ ++
	JSR fix_vram_uw
	JSL load_default_tileset

	LDA $7EC172 : BEQ ++
	JSR fixpegs ; quick and dirty pegs reset

++	LDA #$0F : STA $13
	RTS

fixpegs:

	%ai16()
	LDX #$0000
--	LDA $7EB4C0, X : STA $7F0000, X
	LDA $7EB340, X : STA $7F0080, X
	INX #2 : CPX #$0080 : BNE --
	%ai8()
	LDA #$17 : STA $17
	RTS

fix_vram_uw: ; mostly copied from PalaceMap_RestoreGraphics - pc: $56F19
	PHB
	LDA #$00 : PHA : PLB ; need to be bank00
	LDA $9B : PHA
	STZ $9B : STZ $420C

	JSL $00834B ; Vram_EraseTilemaps.normal

	JSL $00E1DB ; InitTilesets

	JSL $0DFA8C ; HUD.RebuildLong2

.just_redraw
	STZ $0418
	STZ $045C

.drawQuadrants

	JSL $0091C4
	JSL $0090E3
	JSL $00913F
	JSL $0090E3

	LDA $045C : CMP #$10 : BNE .drawQuadrants

	STZ $17
	STZ $B0

	PLA : STA $9B
	PLB : RTS

; wrapper because of push and pull logic
; need this to make it safe and ultimately fix INIDISP ($13)
gamemode_somaria_pits_wrapper:
	%ai8()
	LDA $1B : BEQ ++ ; don't do this outdoors

	LDA #$80 : STA $13 : STA $2100 ; keep fblank on while we do stuff
	JSR gamemode_somaria_pits
	LDA #$0F : STA $13

++	RTS

gamemode_somaria_pits:
	PHB ; rebalanced in redraw
	PEA $007F ; push both bank 00 and bank 7F (wram)
	PLB ; but only pull 7F for now

	%ai16()

	LDY #$0FFE

--	LDA $2000, Y : AND #$00FF ; checks tile attributes table
	CMP #$0020 : BEQ .ispit
	;CMP #$00B0 : BCC .skip
	;CMP #$00BF : BCS .skip ; range B0-BE, which are pits
	BRA .skip

.ispit
	TYA : ASL : TAX
	LDA #$050F : STA $7E2000, X

.skip
	DEY : BPL --

.time_for_tilemaps ; just a delimiting label
	%ai8()
	PLB ; pull to bank 00 for this next stuff

	LDA $9B : PHA ; rebalanced in redraw
	STZ $9B : STZ $420C

	JMP fix_vram_uw_just_redraw ; jmp to have 1 less rts and because of stack

gamemode_lagometer:
	%ai16()
	LDA !lowram_nmi_counter : CMP #$0002 : BCS .lag_frame
	LDA #$3C00 : STA !lowram_draw_tmp

	LDA $2137 : LDA $213D : AND #$00FF : CMP #$007F : BCS .warning
	BRA .draw

.warning
	PHA : LDA #$2800 : STA !lowram_draw_tmp : PLA
	BRA .draw

.lag_frame
	LDA #$3400 : STA !lowram_draw_tmp
	LDA #$00FF

.draw
	STZ !lowram_nmi_counter

	AND #$00FF : LSR : CLC : ADC #$0007 : AND #$FFF8 : TAX

	LDA.l .mp_tilemap+0, X : ORA !lowram_draw_tmp : STA.w SA1HUD+$42
	LDA.l .mp_tilemap+2, X : ORA !lowram_draw_tmp : STA.w SA1HUD+$82
	LDA.l .mp_tilemap+4, X : ORA !lowram_draw_tmp : STA.w SA1HUD+$C2
	LDA.l .mp_tilemap+6, X : ORA !lowram_draw_tmp : STA.w SA1HUD+$102

	%ai8()
	RTS

.mp_tilemap
	dw $00F5, $00F5, $00F5, $00F5
	dw $00F5, $00F5, $00F5, $005F
	dw $00F5, $00F5, $00F5, $004C
	dw $00F5, $00F5, $00F5, $004D
	dw $00F5, $00F5, $00F5, $004E
	dw $00F5, $00F5, $005F, $005E
	dw $00F5, $00F5, $004C, $005E
	dw $00F5, $00F5, $004D, $005E
	dw $00F5, $00F5, $004E, $005E
	dw $00F5, $005F, $005E, $005E
	dw $00F5, $004C, $005E, $005E
	dw $00F5, $004D, $005E, $005E
	dw $00F5, $004E, $005E, $005E
	dw $005F, $005E, $005E, $005E
	dw $004C, $005E, $005E, $005E
	dw $004D, $005E, $005E, $005E
	dw $004E, $005E, $005E, $005E
