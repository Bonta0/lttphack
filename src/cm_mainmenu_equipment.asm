; EQUIPMENT {{{

cm_main_goto_equipment:
	%cm_submenu("Equipment", cm_submenu_equipment)

cm_submenu_equipment:
	dw cm_equipment_fill_magic
	dw cm_equipment_fill_hearts
	dw cm_equipment_fill_rupees

	dw cm_equipment_sword
	dw cm_equipment_shield
	dw cm_equipment_armor

	dw cm_equipment_gloves
	dw cm_equipment_boots
	dw cm_equipment_flippers
	dw cm_equipment_moon_pearl
	dw cm_equipment_half_magic

	dw cm_equipment_maxhp
	dw cm_equipment_bombs
	dw cm_equipment_arrows
	dw cm_equipment_keys
;	dw cm_equipment_goto_small_keys_submenu ; maybe?
	dw cm_equipment_goto_big_keys_submenu

	dw cm_equipment_fill_everything
	dw !menu_end
	%cm_header("EQUIPMENT")

cm_equipment_boots:
	%cm_toggle_jsr("Boots", !ram_equipment_boots)

.toggle
	STA.l !ram_equipment_boots
	LSR ; set carry based on having boots
	LDA.l !ram_capabilities : AND #$FB
	BCC .no_boots
.yes_boots
	ORA #$04
.no_boots
	STA.l !ram_capabilities
	RTS

cm_equipment_gloves:
	dw !CM_ACTION_CHOICE
	dl !ram_equipment_gloves
	%list_item("Gloves")
	%list_item("No")
	%list_item("Power glove")
	%list_item("Titan's mitt")
	db !list_end

cm_equipment_flippers:
	%cm_toggle_jsr("Flippers", !ram_equipment_flippers)

.toggle
	STA.l !ram_equipment_flippers
	LSR ; set carry based on having flippers
	LDA.l !ram_capabilities : AND #$FD
	BCC .no_flips
.yes_flips
	ORA #$02
.no_flips
	STA.l !ram_capabilities
	RTS

cm_equipment_moon_pearl:
	%cm_toggle("Moon pearl", !ram_equipment_moon_pearl)

cm_equipment_half_magic:
	%cm_toggle("Half magic", !ram_equipment_half_magic)

cm_equipment_sword:
	dw !CM_ACTION_CHOICE_JSR
	dw .toggle_sword
	dl !ram_equipment_sword
	%list_item("Sword")
	%list_item("No")
	%list_item("Fighter")
	%list_item("Master")
	%list_item("Tempered")
	%list_item("Gold")
	db !list_end

.toggle_sword
	JSL DecompSwordGfx
	JSL Palette_Sword
	STZ.w $15
	RTS

cm_equipment_shield:
	dw !CM_ACTION_CHOICE_JSR
	dw .toggle_shield
	dl !ram_equipment_shield
	%list_item("Shield")
	%list_item("No")
	%list_item("Fighter")
	%list_item("Red")
	%list_item("Mirror")
	db !list_end

.toggle_shield
	JSL DecompShieldGfx
	JSL Palette_Shield
	STZ.w $15
	RTS

cm_equipment_armor:
	dw !CM_ACTION_CHOICE_JSR
	dw .toggle_armor
	dl !ram_equipment_armor
	%list_item("Armor")
	%list_item("Green")
	%list_item("Blue")
	%list_item("Red")
	db !list_end

.toggle_armor
	JSL Palette_Armor
	STZ.w $15
	RTS

cm_equipment_fill_magic:
	%cm_jsr("Fill magic")

.routine
	LDA #$80 : STA.l !ram_equipment_magic_meter
	RTS

cm_equipment_fill_rupees:
	%cm_jsr("Fill rupees")

.routine
	REP #$20
	; Sets 999 rupees
	LDA #$03E7 : STA $7EF360 : STA $7EF362
	RTS

cm_equipment_fill_hearts:
	%cm_jsr("Fill HP")

.routine
	LDA.l !ram_equipment_maxhp : STA.l !ram_equipment_curhp
	RTS

cm_equipment_fill_everything:
	%cm_jsr("Fill Everything")

.routine
	JSL gamemode_fill_everything
	RTS

cm_equipment_maxhp:
	dw !CM_ACTION_CHOICE_JSR
	dw .set_maxhp
	dl SA1RAM.cm_equipment_maxhp
	%list_item("Max HP")
	%list_item("3")
	%list_item("4")
	%list_item("5")
	%list_item("6")
	%list_item("7")
	%list_item("8")
	%list_item("9")
	%list_item("10")
	%list_item("11")
	%list_item("12")
	%list_item("13")
	%list_item("14")
	%list_item("15")
	%list_item("16")
	%list_item("17")
	%list_item("18")
	%list_item("19")
	%list_item("20")
	db !list_end

.set_maxhp
	LDA.w SA1RAM.cm_equipment_maxhp
	INC #3
	ASL #3
	; Need to fill HP to get immediate effect
	STA.l !ram_equipment_maxhp : STA.l !ram_equipment_curhp
	RTS

cm_equipment_bombs:
	%cm_numfield("Bombs", !ram_item_bombs, #0, #30, #5)

cm_equipment_arrows:
	%cm_numfield("Arrows", !ram_equipment_arrows_filler, #0, #50, #5)

cm_equipment_keys:
	%cm_numfield("Keys", !ram_equipment_keys, #0, #9, #1)

cm_equipment_goto_big_keys_submenu:
	%cm_submenu("Big keys", cm_submenu_big_keys)

cm_submenu_big_keys:
	dw cm_big_keys_sewers
	dw cm_big_keys_hc
	dw cm_big_keys_eastern
	dw cm_big_keys_desert
	dw cm_big_keys_hera
	dw cm_big_keys_aga
	dw cm_big_keys_pod
	dw cm_big_keys_thieves
	dw cm_big_keys_skull
	dw cm_big_keys_ice
	dw cm_big_keys_swamp
	dw cm_big_keys_mire
	dw cm_big_keys_trock
	dw cm_big_keys_gtower

	dw !menu_end
	%cm_header("BIG KEYS")

cm_big_keys_sewers:
	%cm_toggle_bit("Sewers", !ram_game_big_keys_2, #$80)

cm_big_keys_hc:
	%cm_toggle_bit("Hyrule Castle", !ram_game_big_keys_2, #$40)

cm_big_keys_eastern:
	%cm_toggle_bit("Eastern", !ram_game_big_keys_2, #$20)

cm_big_keys_desert:
	%cm_toggle_bit("Desert", !ram_game_big_keys_2, #$10)

cm_big_keys_aga:
	%cm_toggle_bit("ATower", !ram_game_big_keys_2, #$08)

cm_big_keys_swamp:
	%cm_toggle_bit("Swamp", !ram_game_big_keys_2, #$04)

cm_big_keys_pod:
	%cm_toggle_bit("Darkness", !ram_game_big_keys_2, #$02)

cm_big_keys_mire:
	%cm_toggle_bit("Mire", !ram_game_big_keys_2, #$01)

cm_big_keys_skull:
	%cm_toggle_bit("Skull", !ram_game_big_keys_1, #$80)

cm_big_keys_ice:
	%cm_toggle_bit("Ice", !ram_game_big_keys_1, #$40)

cm_big_keys_hera:
	%cm_toggle_bit("Hera", !ram_game_big_keys_1, #$20)

cm_big_keys_thieves:
	%cm_toggle_bit("Thieves", !ram_game_big_keys_1, #$10)

cm_big_keys_trock:
	%cm_toggle_bit("Turtle Rock", !ram_game_big_keys_1, #$08)

cm_big_keys_gtower:
	%cm_toggle_bit("GTower", !ram_game_big_keys_1, #$04)

;-----

cm_equipment_goto_small_keys_submenu:
	%cm_submenu("Small keys", cm_submenu_small_keys)

cm_submenu_small_keys:
	dw cm_small_keys_escape
	dw cm_small_keys_eastern
	dw cm_small_keys_desert
	dw cm_small_keys_hera
	dw cm_small_keys_aga
	dw cm_small_keys_pod
	dw cm_small_keys_thieves
	dw cm_small_keys_skull
	dw cm_small_keys_ice
	dw cm_small_keys_swamp
	dw cm_small_keys_mire
	dw cm_small_keys_trock
	dw cm_small_keys_gtower

	dw !menu_end
	%cm_header("SMALL KEYS")

cm_small_keys_escape:
	%cm_numfield("Escape", $7EF37C, #$00, #$09, #$01)

cm_small_keys_eastern:
	%cm_numfield("Eastern", $7EF37E, #$00, #$09, #$01)

cm_small_keys_desert:
	%cm_numfield("Desert", $7EF37F, #$00, #$09, #$01)

cm_small_keys_hera:
	%cm_numfield("Hera", $7EF386, #$00, #$09, #$01)

cm_small_keys_aga:
	%cm_numfield("ATower", $7EF380, #$00, #$09, #$01)

cm_small_keys_pod:
	%cm_numfield("Darkness", $7EF382, #$00, #$09, #$01)

cm_small_keys_thieves:
	%cm_numfield("Thieves", $7EF387, #$00, #$09, #$01)

cm_small_keys_skull:
	%cm_numfield("Skull", $7EF384, #$00, #$09, #$01)

cm_small_keys_ice:
	%cm_numfield("Ice", $7EF385, #$00, #$09, #$01)

cm_small_keys_swamp:
	%cm_numfield("Swamp", $7EF381, #$00, #$09, #$01)

cm_small_keys_mire:
	%cm_numfield("Mire", $7EF383, #$00, #$09, #$01)

cm_small_keys_trock:
	%cm_numfield("Turtle Rock", $7EF388, #$00, #$09, #$01)

cm_small_keys_gtower:
	%cm_numfield("GTower", $7EF389, #$00, #$09, #$01)


; }}}