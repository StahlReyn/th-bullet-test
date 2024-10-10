class_name Player
extends Character

@export var base_speed : int = 400 ## pixels/sec
@export var focus_speed : int = 100 ## pixels/sec
@export var area_graze : AreaGraze
@export var audio_shoot : AudioStreamPlayer2D ## shoot audio is done on player side to not overlap multiple shooters
@export var audio_item : AudioStreamPlayer2D ## Audio for item collection
@onready var game_view : GameView = $".."

var lives : int = 3
var bombs : int = 3
var power : int = 0 ##Powers are in integer for simplicity, display divides by 100

var power_min : int = 0
var power_max : int = 500

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

func _on_area_entered(area: Area2D) -> void:
	super(area)
	if area is Item:
		area.do_collect()
		audio_item.play()
		process_item(area)

func process_item(item: Item) -> void:
	match item.type:
		Item.Type.POWER:
			power += 1
		Item.Type.POWER_BIG:
			power += 100
		Item.Type.POWER_FULL:
			power += 500
		Item.Type.POINT:
			GameUtils.add_score(self, 1000)

func add_power(value: float) -> void:
	power += value
	power = clamp(power, power_min, power_max)
