class_name  Damagable
extends Area2D

signal damaged(amount: int, normal: Vector2)

func damage(amount := 1, normal := Vector2(0,0)):
	damaged.emit(amount, normal)
