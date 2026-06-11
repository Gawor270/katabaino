extends "res://maps/base_map.gd"

const ZOOM_NORMAL := Vector2(4.0, 4.0)
const ZOOM_WIDE := Vector2(3.0, 3.0)
const ZOOM_THRESHOLD := -250.0
const ZOOM_SPEED := 2.5

var _camera: Camera2D
var _player: Node2D

func _ready() -> void:
	super._ready()
	_camera = find_child("Camera", true, false)
	_player = find_child("Player", true, false)

func _process(delta: float) -> void:
	if _camera == null or _player == null:
		return
	var target_zoom := ZOOM_WIDE if _player.global_position.y < ZOOM_THRESHOLD else ZOOM_NORMAL
	_camera.zoom = _camera.zoom.lerp(target_zoom, ZOOM_SPEED * delta)
