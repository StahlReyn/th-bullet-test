class_name GameView
extends Node2D

signal game_start

var game_time : float = 0.0
var score : int = 0
var graze_count : int = 0

func _ready() -> void:
	game_start.emit()
	pass

func _process(delta: float) -> void:
	game_time += delta
