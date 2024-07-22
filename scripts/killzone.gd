extends Area2D


func _on_body_entered(body):
	print("You DIED!")
	body.get_node("CollisionShape2D").queue_free()
	GameManager.reload_game()
