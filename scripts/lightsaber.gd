extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var ray_cast_2d = $RayCast2D
@onready var animated_sprite_2d = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		animation_player.stop()
		animation_player.play("attack")
		

func on_attack():
	var colliders = _get_colliders_from_ray_cast(ray_cast_2d)
	for collider in colliders:
		if collider is Damagable:
			collider.damage(50, ray_cast_2d.get_collision_normal())

func _get_colliders_from_ray_cast(ray_cast: RayCast2D):
	var colliders = []
	while ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		colliders.append(collider)
		ray_cast.add_exception(collider)
		ray_cast.force_raycast_update()
		
	ray_cast.clear_exceptions()
	return colliders
