class_name Player
extends Character

@export var base_speed : int = 400 ## pixels/sec
@export var focus_speed : int = 100 ## pixels/sec
@export var area_graze : AreaGraze
@export var audio_shoot : AudioStreamPlayer2D ## shoot audio is done on player side to not overlap multiple shooters
@onready var game_view : GameView = $".."

var lives : int
var bombs : int
var power : float

func process_movement_input() -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x = get_speed()
	if Input.is_action_pressed("move_left"):
		velocity.x = -get_speed()
	if Input.is_action_pressed("move_down"):
		velocity.y = get_speed()
	if Input.is_action_pressed("move_up"):
		velocity.y = -get_speed()
	if Input.is_action_pressed("shoot") and not audio_shoot.playing:
		audio_shoot.play()

func process_movement(delta) -> void:
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, GameUtils.get_game_area())

func get_speed():
	if Input.is_action_pressed("focus"):
		return focus_speed
	return base_speed
