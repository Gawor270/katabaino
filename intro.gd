extends Node2D

@export var scroll_speed: float = 600.0 # How fast the forest rushes by
@export_file("*.tscn") var next_scene_path: String
@export var target_spawn_point: String = ""

# Drag and drop your ParallaxLayer here!
@onready var parallax_layer = $ParallaxBackground/ParallaxLayer

func _ready() -> void:
	start_intro_timer()

func _process(delta: float) -> void:
	# Instead of moving the background, we move the layer's motion offset!
	# This completely bypasses the Camera2D.
	parallax_layer.motion_offset.x -= scroll_speed * delta

func start_intro_timer() -> void:
	await get_tree().create_timer(11.0).timeout
	Events.map_change_requested.emit(next_scene_path, target_spawn_point)
