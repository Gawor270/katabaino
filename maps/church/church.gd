extends "res://maps/base_map.gd"

func _ready() -> void:
	super._ready()
	var camera = find_child("Camera", true, false)
	if camera:
		camera.zoom = Vector2(2, 2)
