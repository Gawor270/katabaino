extends CharacterBody2D

# @export allows you to change the speed directly in the Inspector later!
@export var speed: float = 45.0 

# Connect our nodes to the script
@onready var anim_player = $Anim
@onready var interact_ray = $InteractRay

# Keeps track of where we are looking when we stop moving
var facing_direction: Vector2 = Vector2.DOWN 

func _physics_process(_delta: float) -> void:
	# 1. Get player input (using Godot's built-in arrow key actions)
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# 2. Apply movement
	velocity = input_dir * speed
	move_and_slide()
	
	# 3. Handle animations and raycast direction
	update_facing_and_animations(input_dir)

func update_facing_and_animations(input_dir: Vector2) -> void:
	# If the player is pressing a movement key...
	if input_dir != Vector2.ZERO:
		facing_direction = input_dir
		
		# Point the RayCast 16 pixels in the direction we are walking
		interact_ray.target_position = facing_direction * 16.0
		
		# Play the correct walk animation
		if input_dir.x < 0:
			anim_player.play("walk_left")
		elif input_dir.x > 0:
			anim_player.play("walk_right")
		elif input_dir.y < 0:
			anim_player.play("walk_up")
		elif input_dir.y > 0:
			anim_player.play("walk_down")
			
	# If the player lets go of the keys...
	else:
		# Stop the animation so the character stands still
		anim_player.stop() 
		
		# Note: If you made dedicated idle animations (like "idle_down"), 
		# you would play them right here instead of stopping the player!

func _unhandled_input(event: InputEvent) -> void:
	# Check if the key we just pressed was the "interact" action
	if event.is_action_pressed("interact"):
		
		# Force the RayCast to update instantly before we check it
		interact_ray.force_raycast_update()
		
		# Did the laser pointer hit an Area2D?
		if interact_ray.is_colliding():
			var target = interact_ray.get_collider()
			
			# Does the thing we hit have our custom function?
			if target.has_method("_on_interacted"):
				target._on_interacted()
		
		# Did we press 'X', AND do we actually own the bicycle?
	if event.is_action_pressed("use_effect") and PlayerData.has_bicycle:
		
		# Toggle the state (if true, make false. If false, make true)
		PlayerData.is_riding_bicycle = not PlayerData.is_riding_bicycle
		
		# Apply the effect!
		if PlayerData.is_riding_bicycle:
			speed = 90.0 # Double speed!
			print("Equipped Bicycle!")
		else:
			speed = 45.0 # Back to normal speed
			print("Unequipped Bicycle!")
