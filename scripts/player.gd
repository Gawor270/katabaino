extends CharacterBody2D

@export var speed := 100.0

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	velocity = input_vector * speed
	move_and_slide()

@onready var anim = $AnimatedSprite2D

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		anim.play("walk")
	elif Input.is_action_pressed("ui_left"):
		anim.play("walk")
	else:
		anim.play("idle")
