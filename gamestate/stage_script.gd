class_name StageScript
extends Node

var time_elapsed : float = 0.0

func _ready() -> void:
	time_elapsed = 0.0

func _process(delta: float) -> void:
	time_elapsed += delta

func spawn_enemy(scene : PackedScene, pos : Vector2 = Vector2(0,0)) -> Enemy:
	var enemy_container = get_enemy_container()
	var enemy : Enemy = scene.instantiate()
	enemy.global_position = pos
	enemy_container.add_child(enemy)
	return enemy

func get_enemy_container() -> Node:
	return get_parent().get_parent()
