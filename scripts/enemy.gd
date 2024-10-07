class_name Enemy
extends Area2D

var total_time : float = 0;
var bullet_scene : PackedScene = preload("res://scripts/bullet.tscn")
var to_spawn = true
var game_view : GameView

func _ready() -> void:
	game_view = get_parent()
	pass

func _process(delta: float) -> void:
	total_time += delta
	
	if to_spawn:
		to_spawn = false
		var bullet = bullet_scene.instantiate()
		bullet.velocity = get_to_player_direction() * 200
		add_child(bullet)
		await get_tree().create_timer(1).timeout
		to_spawn = true

func get_to_player_vector():
	var player = game_view.get_player()
	return player.position - self.position

func get_to_player_direction():
	return get_to_player_vector().normalized()
