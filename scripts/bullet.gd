class_name Bullet
extends Area2D

var velocity = Vector2.ZERO

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	process_movement(delta)

func process_movement(delta) -> void:
	position += velocity * delta
