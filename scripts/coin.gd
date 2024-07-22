extends Area2D

@onready var scene_manager: Node = %SceneManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	scene_manager.add_point()
	animation_player.play("pickup")
