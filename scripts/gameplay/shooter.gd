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
	var player = GameUtils.get_player(self)
	var bullet_container = GameUtils.get_bullet_container(self)
	var bullet : Bullet = bullet_scene.instantiate()
	bullet.top_level = true
	bullet.global_position = self.global_position
	if aim_at_player:
		bullet.velocity = bullet.position.direction_to(player.position) * base_speed
	else:
		bullet.velocity = Vector2.UP * base_speed
	bullet_container.add_child(bullet)
	reset_cooldown()

func reset_cooldown() -> void:
	cooldown_time = cooldown
