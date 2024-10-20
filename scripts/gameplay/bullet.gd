class_name Bullet
extends Area2D

@export_group("Visuals")
@export var main_sprite : Sprite2D
@export var bullet_hit_effect_scene : PackedScene
@export var rotation_based_on_velocity : bool = true
@export_group("Gameplay")
@export var damage : int = 1
@export var penetration : int = 1
@export var velocity : Vector2 = Vector2.ZERO

var total_time : float
var penetration_count : int

var movement_handler : MovementHandler # Movement Handler is auto created

func _ready() -> void:
	total_time = 0.0
	penetration_count = penetration
	movement_handler = MovementHandler.new()
	add_child(movement_handler)

func _physics_process(delta: float) -> void:
	total_time += delta
	movement_handler.process_script(delta)
	process_movement(delta)
	check_remove()

func process_movement(delta) -> void:
	position += velocity * delta
	if rotation_based_on_velocity:
		rotation = velocity.angle()

func check_remove() -> void:
	if position.x > 1000 or position.x < -200 or position.y > 1000 or position.y < -200:
		call_deferred("queue_free")

func on_hit():
	penetration_count -= 1
	if penetration_count <= 0:
		if bullet_hit_effect_scene:
			AfterEffect.add_effect(bullet_hit_effect_scene, self)
		call_deferred("queue_free")
	
func add_movement_script(script : GDScript) -> Node:
	return movement_handler.add_movement_script(self, script)

func set_color(type: int, variant: int) -> void:
	if main_sprite is SpriteGroupBasicBullet:
		main_sprite.set_color(type, variant)
	else:
		push_warning("Cannot set color to non-sprite group bullets")

func set_random_color(variant: int) -> void:
	if main_sprite is SpriteGroupBasicBullet:
		main_sprite.set_random_color(variant)
	else:
		push_warning("Cannot set color to non-sprite group bullets")
