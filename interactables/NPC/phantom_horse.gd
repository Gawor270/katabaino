extends Node2D

@export var speed: float = 150.0
@export var min_delay: float = 5.0
@export var max_delay: float = 12.0

var is_dashing: bool = false
var end_x: float = 0.0

@onready var gallop_sound: AudioStreamPlayer2D = $GallopSound

func _ready() -> void:
	hide()
	start_random_timer()

func start_random_timer() -> void:
	var wait_time = randf_range(min_delay, max_delay)
	await get_tree().create_timer(wait_time).timeout
	start_dash()

func start_dash() -> void:
	# 1. Find the active camera (which follows the player)
	var camera = get_viewport().get_camera_2d()
	if camera == null:
		start_random_timer() # If no camera, just wait and try again later
		return
		
	# 2. Get the size of the player's game window
	var screen_size = get_viewport_rect().size
	
	var cam_pos = camera.global_position
	
	# 4. Calculate coordinates slightly outside the screen bounds (buffer of 100 pixels)
	var offscreen_distance = (screen_size.x / 2.0) + 100.0
	
	# Set the starting X and the target ending X
	global_position.x = cam_pos.x + offscreen_distance
	end_x = cam_pos.x - offscreen_distance
	
	# 5. Pick a random Y height so it doesn't always pass by at the exact same vertical spot
	global_position.y = cam_pos.y + randf_range(-screen_size.y/5.0, screen_size.y/5.0)

	show()
	gallop_sound.play()
	is_dashing = true

func _process(delta: float) -> void:
	if is_dashing:
		# Move the horse in the chosen direction
		global_position.x -= (speed) * delta
		
		# Check if it has crossed the end point
		var finished_running = false
		if global_position.x < end_x:
			finished_running = true
			
		if finished_running:
			is_dashing = false
			hide()
			gallop_sound.stop()
			start_random_timer()
