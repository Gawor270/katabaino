extends Node2D

@export var level_music: AudioStream
@onready var player: CharacterBody2D = $YSortContainer/Entities/Player

func _ready() -> void:
	if level_music:
		# call_deferred ensures Main is completely ready before we shout!
		Events.music_requested.emit.call_deferred(level_music)
