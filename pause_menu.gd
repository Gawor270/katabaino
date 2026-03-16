extends Control

func _ready() -> void:
	# Double-check that the menu is hidden when the game boots up
	hide()

func _unhandled_input(event: InputEvent) -> void:
	# "ui_cancel" is Godot's built-in action for the Escape key or gamepad B/Circle
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	# 1. Flip the game's paused state (If true, make false. If false, make true)
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	
	# 2. Show or hide this menu based on that state
	visible = new_pause_state
