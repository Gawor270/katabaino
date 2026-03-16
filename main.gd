extends Node

@onready var world_container = $WorldContainer
@onready var fade_anim = $UILayer/ScreenFade/AnimationPlayer
@onready var global_music = $GlobalMusic 

# Changed from _enter_tree to _ready!
func _ready() -> void:
	Events.music_requested.connect(play_music)
	Events.map_change_requested.connect(transition_to_map)

func transition_to_map(new_map_path: String, spawn_point_name: String) -> void:
	fade_anim.play("fade")
	await fade_anim.animation_finished
	
	# Delete the old map
	for child in world_container.get_children():
		child.queue_free()
		
	# Load and add the new map
	var next_map_resource = load(new_map_path)
	var next_map = next_map_resource.instantiate()
	world_container.add_child(next_map)
	
	# --- NEW SPAWN LOGIC ---
	# If the door gave us a specific marker name to look for...
	if spawn_point_name != "":
		# Search the new map for the Marker2D and the Player
		var spawn_marker = next_map.find_child(spawn_point_name, true, false)
		var player = next_map.find_child("Player", true, false)
		
		# If we found both, instantly move the player to the marker's exact position!
		if spawn_marker != null and player != null:
			player.global_position = spawn_marker.global_position
	# -----------------------
	
	fade_anim.play_backwards("fade")

func play_music(new_stream: AudioStream) -> void:
	if global_music.stream == new_stream and global_music.playing:
		return 
	global_music.stream = new_stream
	global_music.play()
