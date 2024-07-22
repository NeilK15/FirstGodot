extends RigidBody2D

@export var speed = 60
@export var health = 100

const DAMAGE_VELOCITY = 100

var direction = 1
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_right_down = $RayCastRightDown
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_left_down = $RayCastLeftDown
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding() or not ray_cast_right_down.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding() or not ray_cast_left_down.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	position.x += direction * speed * 1/60
	

func _on_damagable_damaged(amount: int, normal: Vector2):
	health -= amount
	print(normal)
	
	var bounce_back_dir: Vector2 = Vector2(0, -1)
	if normal.x > 0:
		bounce_back_dir = Vector2(-1, -1)
	elif normal.x < 0:
		bounce_back_dir = Vector2(1, -1)
	
	var bounce_back: Vector2 = bounce_back_dir.normalized() * DAMAGE_VELOCITY
	apply_impulse(bounce_back)
	
	print("OW")
	if health <= 0:
		queue_free()
		# play death animation
	else:
		# play hurt animation
		animated_sprite.play("hurt")
