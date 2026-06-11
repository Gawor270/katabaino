extends CanvasLayer

var _player: Node

func _ready() -> void:
	_player = get_parent().find_child("Player", true, false)
	if PlayerData.tutorial_seen:
		queue_free()
		return
	if _player:
		_player.process_mode = Node.PROCESS_MODE_DISABLED

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		PlayerData.tutorial_seen = true
		if _player:
			_player.process_mode = Node.PROCESS_MODE_INHERIT
		queue_free()
