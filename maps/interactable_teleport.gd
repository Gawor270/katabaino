extends Area2D

@export_file("*.tscn") var next_scene_path: String
@export var target_spawn_point: String = ""

func _on_interacted():
	Events.map_change_requested.emit(next_scene_path, target_spawn_point)
