class_name Bullet
extends Area2D

var velocity = Vector2.ZERO
var game_view : GameView
var credit
var damage

func _ready() -> void:
	#game_view = get_node("/root/Gamemain/Gameview")
	#print(game_view)
	pass

func _process(delta: float) -> void:
	process_movement(delta)
	check_remove()

func process_movement(delta) -> void:
	position += velocity * delta

func check_remove() -> void:
	if global_position.x > 1600 or global_position.x < -400 or global_position.y > 1600 or global_position.y < -400:
		queue_free()
