extends "res://interactables/interactable.gd"

@export_file("*.tscn") var next_scene_path: String
@export var target_spawn_point: String = ""
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_interacted():
	animation_player.play("open")
	Events.map_change_requested.emit(next_scene_path, target_spawn_point)
