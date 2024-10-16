class_name Bullet
extends Area2D

@export var audio_spawn : AudioStreamPlayer2D
@export var bullet_hit_effect_scene : PackedScene
@export var damage : int = 1
@export var penetration : int = 1

var velocity : Vector2 = Vector2.ZERO
var total_time : float
var penetration_count : int

var movement_handler : MovementHandler # Movement Handler is auto created

func _ready() -> void:
	total_time = 0.0
	penetration_count = penetration
	movement_handler = MovementHandler.new()
	add_child(movement_handler)
	if audio_spawn:
		audio_spawn.play()

func _physics_process(delta: float) -> void:
	total_time += delta
	movement_handler.process_script(delta)
	process_movement(delta)
	check_remove()

func process_movement(delta) -> void:
	position += velocity * delta

func check_remove() -> void:
	if position.x > 1000 or position.x < -300 or position.y > 1000 or position.y < -300:
		queue_free()

func on_hit():
	penetration_count -= 1
	if penetration_count <= 0:
		if bullet_hit_effect_scene:
			AfterEffect.add_effect(bullet_hit_effect_scene, self)
		queue_free()
	
func add_movement_script(script : GDScript) -> Node:
	return movement_handler.add_movement_script(self, script)
