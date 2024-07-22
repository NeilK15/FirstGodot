extends Node

@onready var death_timer: Timer = $DeathTimer

func reload_game():
	Engine.time_scale = 0.5
	death_timer.start()


func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
