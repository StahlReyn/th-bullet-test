class_name GameView
extends Node2D

@onready var game_area : Vector2 = $Area2D/CollisionShape2D.get_shape().size
var game_time : float = 0.0
var score : int = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	game_time += delta

func get_player() -> Player:
	return get_tree().get_nodes_in_group("player")[0]

func get_bullet_count() -> int:
	return len(get_tree().get_nodes_in_group("bullet"))

func get_game_area() -> Vector2:
	return game_area
