extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const COYOTE_TIME = 3 # in frames

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	jump()
	
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
			
	else:
		animated_sprite.play("jump")
		
	
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

var coyote_time_frame = 3
var in_coyote_time = false

func jump():
	if is_on_floor():
		coyote_time_frame = 0
		
	if not is_on_floor() and coyote_time_frame < COYOTE_TIME:
		in_coyote_time = true

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or in_coyote_time:
			velocity.y = JUMP_VELOCITY
			in_coyote_time = false
			coyote_time_frame = COYOTE_TIME + 1
