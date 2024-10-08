class_name Player
extends Character

signal graze

@export var base_speed : int = 400 # pixels/sec
@export var focus_speed : int = 100 # pixels/sec
@export var area_graze : AreaGraze
@export var audio_graze : AudioStreamPlayer2D
@onready var game_view : GameView = $".."

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

func process_movement(delta) -> void:
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, GameUtils.get_game_area())

func get_speed():
	if Input.is_action_pressed("focus"):
		return focus_speed
	return base_speed

func _on_area_graze_area_entered(area: Area2D) -> void:
	if area is Bullet:
		graze.emit()
		audio_graze.play()
		#print("GRAZE!")
