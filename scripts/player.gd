class_name Player
extends Area2D

signal hit

@export var base_speed : int = 400 # pixels/sec
@export var focus_speed : int = 100 # pixels/sec
@onready var main_anim_node : AnimatedSprite2D = $AnimatedSprite2D
@onready var main_collision : CollisionShape2D = $CollisionShape2D
@onready var game_view : GameView = $".."

var velocity = Vector2.ZERO

func _ready() -> void:
	#hide()
	pass

func _process(delta: float) -> void:
	process_movement_input()
	process_movement(delta)
	
	if velocity.length() > 0:
		main_anim_node.play()
	else:
		main_anim_node.stop()

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
	position = position.clamp(Vector2.ZERO, game_view.get_game_area())

func get_speed():
	if Input.is_action_pressed("focus"):
		return focus_speed
	return base_speed

func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		hit.emit()
		print("HIT!")
		# Must be deferred as we can't change physics properties on a physics callback.
		# main_collision.set_deferred("disabled", true)
