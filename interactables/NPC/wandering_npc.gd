extends CharacterBody2D

# 1. Define our States
enum State { IDLE, WANDER }
var current_state = State.IDLE
var wander_direction : Vector2 = Vector2.ZERO
@export var speed: float = 25.0 # Slow, creepy walking speed

@onready var wander_timer = $WanderTimer
@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	# Ensure true randomness on startup
	randomize() 

func _physics_process(_delta: float) -> void:
	if current_state == State.WANDER:
		velocity = wander_direction * speed
	else:
		velocity = Vector2.ZERO 
		
	move_and_slide()
	
	# After we calculate physics, we tell the visuals to update!
	update_animation()

func update_animation() -> void:
	# If we are standing still, play idle and stop checking
	if velocity == Vector2.ZERO:
		anim_player.play("idle")
		return
		
	# We use absolute value (abs) to check if the NPC is moving 
	# MORE horizontally or MORE vertically.
	if abs(velocity.x) > abs(velocity.y):
		# Horizontal Movement
		if velocity.x < 0:
			anim_player.play("walk_left")
		else:
			anim_player.play("walk_right")
	else:
		# Vertical Movement
		if velocity.y < 0:
			anim_player.play("walk_up")
		else:
			anim_player.play("walk_down")

# 3. The "Decision Maker" (Runs every time the timer ticks)
func _on_wander_timer_timeout() -> void:
	# Flip a coin: 0 or 1
	var coin_flip = randi() % 2 
	
	if coin_flip == 0:
		# Go to sleep/stop walking
		current_state = State.IDLE
	else:
		# Wake up and pick a direction!
		current_state = State.WANDER
		
		# Pick a random X and Y between -1.0 and 1.0, then normalize it 
		# so diagonal movement isn't faster than straight movement.
		var random_x = randf_range(-1.0, 1.0)
		var random_y = randf_range(-1.0, 1.0)
		wander_direction = Vector2(random_x, random_y).normalized()
		
	# Give the timer a random wait time before making the next decision (1 to 3 seconds)
	wander_timer.wait_time = randf_range(1.0, 3.0)
	wander_timer.start()
