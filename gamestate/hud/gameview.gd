class_name GameView
extends Node2D

@onready var game_area : Vector2 = $Area2D/CollisionShape2D.get_shape().size

func get_player() -> Player:
	return get_tree().get_nodes_in_group("player")[0]

func get_game_area() -> Vector2:
	return game_area
