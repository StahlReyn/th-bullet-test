class_name Item
extends Area2D

static var item_scene : PackedScene = preload("res://scripts/items/item_point.tscn")

var max_speed : float = 200
var down_speed : float = -100
var down_accel : float = 200

var spawn_velocity : Vector2
var spawn_time : float

var magnet_speed : float = 1000
var magnet_target : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_time -= delta
	if magnet_target:
		process_target_movement(delta)
	elif spawn_time > 0: # Gravity move when not spawning
		process_spawn_movement(delta)
	else:
		process_movement(delta)
	check_despawn()

func process_movement(delta: float) -> void:
	down_speed += down_accel * delta
	down_speed = min(down_speed, max_speed)
	position.y += down_speed * delta

func process_spawn_movement(delta: float) -> void:
	position += spawn_velocity * delta
	
func process_target_movement(delta: float) -> void:
	var direction = magnet_target.global_position - self.global_position
	direction = direction.normalized()
	self.position += direction * magnet_speed * delta
	
func set_random_spawn_velocity(speed : float, time : float):
	self.spawn_time = randf_range(0, time)
	var direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	self.spawn_velocity = direction * speed

func do_collect() -> void:
	queue_free()

func check_despawn() -> void:
	if position.y > 1200:
		queue_free()
