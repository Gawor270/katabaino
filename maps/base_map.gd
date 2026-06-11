extends Node2D

@export var level_music: AudioStream

func _ready() -> void:
	if level_music:
		Events.music_requested.emit.call_deferred(level_music)
