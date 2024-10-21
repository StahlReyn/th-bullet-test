class_name Entity
extends Area2D
## This is the largest class for everything gameplay object
## Includes Characters, Bullets, Enemies, Players
## This is the class ModScript targets

signal hit
signal hit_wall
signal exit_wall

static var despawn_coord : PackedVector2Array = [
	Vector2(-100,-100), Vector2(900,1000)
]

@export var delay_time : float = 0.0
@export var velocity : Vector2 = Vector2.ZERO
@export var do_check_despawn : bool = true
@export var movement_handler : MovementHandler ## Movement Handler is auto created if empty

var total_time : float = 0.0
var active_time : float = 0.0
var hit_count : int = 0
var in_wall = false

func _init() -> void:
	# Auto create Movement Handler
	if movement_handler == null:
		movement_handler = MovementHandler.new()
		movement_handler.name = "MovementHandlerAuto"
		add_child(movement_handler)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	total_time += delta
	if is_active():
		physics_process_active(delta)

func physics_process_active(delta: float) -> void:
	active_time += delta
	movement_handler.process_script(delta)
	process_movement(delta)
	check_hit_wall()
	if do_check_despawn:
		check_despawn()

func is_active():
	return total_time >= delay_time

func process_movement(delta) -> void:
	position += velocity * delta

func check_hit_wall() -> void:
	if (position.x > GameUtils.game_area.x 
			or position.x < 0 
			or position.y > GameUtils.game_area.y
			or position.y < 0):\
			if not in_wall: # emit only once
				hit_wall.emit()
				in_wall = true
	else:
		in_wall = false
		exit_wall.emit()

func check_despawn() -> void:
	if (position.x > despawn_coord[1].x 
		or position.x < despawn_coord[0].x
		or position.y > despawn_coord[1].y  
		or position.y < despawn_coord[0].y):
		call_deferred("queue_free")

func on_hit():
	hit.emit()
	hit_count += 1
	
func add_movement_script(script : GDScript) -> Node:
	if movement_handler == null:
		printerr(self, " / Entity: Movement Handler is Nil")
		return null
	return movement_handler.add_movement_script(self, script)
