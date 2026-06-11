extends Control

func _ready() -> void:
	hide()
	_setup_pixel_theme()

func _setup_pixel_theme() -> void:
	var font: FontFile = load("res://assets/fonts/PressStart2P.ttf")
	font.antialiasing  = TextServer.FONT_ANTIALIASING_NONE
	font.hinting       = TextServer.HINTING_NONE
	font.subpixel_positioning = TextServer.SUBPIXEL_POSITIONING_DISABLED

	# Palette — dark gothic / forest spirit
	var BG     := Color(0.03, 0.04, 0.09, 0.97)
	var BORDER := Color(0.52, 0.60, 0.78, 1.0)
	var HOVER  := Color(0.11, 0.15, 0.27, 1.0)
	var PRESS  := Color(0.52, 0.60, 0.78, 1.0)
	var TEXT   := Color(0.85, 0.88, 0.94, 1.0)
	var TXINV  := Color(0.03, 0.04, 0.09, 1.0)

	var theme := Theme.new()

	theme.set_stylebox("normal",   "Button", _flat(BG,   BORDER, 2, 12, 6))
	theme.set_stylebox("hover",    "Button", _flat(HOVER, BORDER, 2, 12, 6))
	theme.set_stylebox("pressed",  "Button", _flat(PRESS, TXINV,  2, 12, 6))
	theme.set_stylebox("focus",    "Button", _flat(BG,    TEXT,   2, 12, 6))
	theme.set_stylebox("disabled", "Button", _flat(BG,    Color(BORDER, 0.35), 2, 12, 6))

	theme.set_font("font",          "Button", font)
	theme.set_font_size("font_size","Button", 8)
	theme.set_color("font_color",           "Button", TEXT)
	theme.set_color("font_hover_color",     "Button", TEXT)
	theme.set_color("font_pressed_color",   "Button", TXINV)
	theme.set_color("font_focus_color",     "Button", TEXT)

	theme.set_font("font",          "Label", font)
	theme.set_font_size("font_size","Label", 8)
	theme.set_color("font_color",   "Label", TEXT)

	self.theme = theme

	# Dark overlay
	$PauseBackground.color = Color(0, 0, 0, 0.72)

	# Title
	var lbl := $Label
	lbl.add_theme_font_size_override("font_size", 10)
	lbl.text = "* PAUSED *"
	lbl.offset_left  = -110
	lbl.offset_right =  110

	# Widen the button container
	var vbox := $VBoxContainer
	vbox.offset_left  = -95
	vbox.offset_right =  95
	vbox.add_theme_constant_override("separation", 10)
	for child in vbox.get_children():
		if child is Button:
			child.size_flags_horizontal = Control.SIZE_EXPAND_FILL

func _flat(bg: Color, border: Color, bw: int, hm: int, vm: int) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color            = bg
	s.border_color        = border
	s.border_width_left   = bw
	s.border_width_top    = bw
	s.border_width_right  = bw
	s.border_width_bottom = bw
	s.corner_radius_top_left     = 0
	s.corner_radius_top_right    = 0
	s.corner_radius_bottom_left  = 0
	s.corner_radius_bottom_right = 0
	s.content_margin_left   = hm
	s.content_margin_right  = hm
	s.content_margin_top    = vm
	s.content_margin_bottom = vm
	return s

func _unhandled_input(event: InputEvent) -> void:
	# "ui_cancel" is Godot's built-in action for the Escape key or gamepad B/Circle
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause() -> void:
	# 1. Flip the game's paused state (If true, make false. If false, make true)
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	
	# 2. Show or hide this menu based on that state
	visible = new_pause_state


func _on_resume_button_pressed() -> void:
	toggle_pause()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
