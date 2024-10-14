extends Node

var game_time : float = 0.0
var score : int = 0
var graze : int = 0
var point_value : int = 10000

var lives : int = 3
var bombs : int = 3
var power : int = 0 ##Powers are in integer for simplicity, display divides by 100

static var power_min : int = 0
static var power_max : int = 400

func reset_variables() -> void:
	game_time = 0.0
	score = 0
	graze = 0
	lives = 3
	bombs = 3
	power = 0
	point_value = 10000

func add_score(value: int) -> void:
	score += value

func add_graze_count(value:int = 1) -> void:
	graze += value

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

func get_score_display():
	return thousands_sep(score)

func get_power_display():
	return two_decimal_int(power) + "/" + two_decimal_int(power_max)

func get_point_value_display():
	return thousands_sep(point_value)

func get_graze_display():
	return thousands_sep(graze)

static func two_decimal_int(number : int) -> String:
	return "%.2f" % (float(number) / 100)
	
static func thousands_sep(number, prefix='') -> String:
	number = int(number)
	var neg = false
	if number < 0:
		number = -number
		neg = true
	var string = str(number)
	var mod = string.length() % 3
	var res = ""
	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]
	if neg: res = '-'+prefix+res
	else: res = prefix+res
	return res
