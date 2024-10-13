extends Node

var game_time : float = 0.0
var score : int = 0
var graze_count : int = 0

func add_score(value: int) -> void:
	score += value

func add_graze_count(value:int = 1) -> void:
	score += value
