class_name GameView
extends Node2D

var game_time : float = 0.0
var score : int = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	game_time += delta
