class_name Shooter
extends Node2D

@export var bullet_scene : PackedScene
@export var cooldown : float = 0.05
@export var aim_at_player : bool = false
@export var base_speed : float = 2000

var cooldown_time : float

func _ready() -> void:
	reset_cooldown()

func _process(delta: float) -> void:
	cooldown_time -= delta
	if can_shoot():
		do_shoot()

func can_shoot() -> bool:
	return cooldown_time <= 0

func do_shoot() -> void:
	var bullet : Bullet = bullet_scene.instantiate()
	bullet.top_level = true
	bullet.global_position = self.global_position
	if aim_at_player:
		bullet.velocity = get_to_player_direction()
	else:
		bullet.velocity = Vector2.UP
	bullet.velocity *= base_speed
	
	var bullet_container = get_bullet_container()
	bullet_container.add_child(bullet)
	reset_cooldown()

func reset_cooldown() -> void:
	cooldown_time = cooldown
	
func get_bullet_container() -> BulletContainer:
	return get_tree().get_nodes_in_group("bullet_container")[0]

func get_player() -> Player:
	return get_tree().get_nodes_in_group("player")[0]

func get_to_player_vector() -> Vector2:
	var player = get_player()
	return player.global_position - self.global_position
	
func get_to_player_direction() -> Vector2:
	return get_to_player_vector().normalized()
