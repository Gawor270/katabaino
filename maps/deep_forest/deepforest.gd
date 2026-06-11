extends Node2D

@export var level_music: AudioStream
@export var map_left: float = 0.0
@export var map_right: float = 0.0

@onready var player: CharacterBody2D = $YSortContainer/Player
@onready var camera: Camera2D = $YSortContainer/Player/Camera

func _ready() -> void:
	if level_music:
		# call_deferred ensures Main is completely ready before we shout!
		Events.music_requested.emit.call_deferred(level_music)

func _process(_delta: float) -> void:
	var pos = player.global_position
	var map_width = map_right - map_left
	var wrapped = false
	if pos.x > map_right:
		pos.x -= map_width
		wrapped = true
	elif pos.x < map_left:
		pos.x += map_width
		wrapped = true
	if wrapped:
		player.global_position = pos
		camera.reset_smoothing()
