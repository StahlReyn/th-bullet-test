extends Node

var game_time : float = 0.0
var score : int = 0
var graze_count : int = 0

var lives : int = 3
var bombs : int = 3
var power : int = 0 ##Powers are in integer for simplicity, display divides by 100

static var power_min : int = 0
static var power_max : int = 500

func reset_variables() -> void:
	game_time = 0.0
	score = 0
	graze_count = 0
	lives = 3
	bombs = 3
	power = 0

func add_score(value: int) -> void:
	score += value

func add_graze_count(value:int = 1) -> void:
	score += value

func add_lives(value:int = 1) -> void:
	lives += value

func lose_lives(value:int = 1) -> void: ## Remove counterpart for clarity and debugging purposes
	lives -= value

func add_bombs(value:int = 1) -> void:
	bombs += value

func lose_bombs(value:int = 1) -> void:
	bombs -= value

func add_power(value:int = 1) -> void:
	power += value
	power = clamp(power, power_min, power_max)

func lose_power(value:int = 1) -> void:
	power += value
	power = clamp(power, power_min, power_max)
