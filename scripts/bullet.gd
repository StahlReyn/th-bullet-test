class_name Bullet
extends Area2D

@export var audio_spawn : AudioStreamPlayer2D
@export var bullet_hit_effect_scene : PackedScene
@export var damage : int = 1
@export var penetration : int = 1
var velocity = Vector2.ZERO
var penetration_count

func _ready() -> void:
	penetration_count = penetration
	if audio_spawn:
		audio_spawn.play()
	pass

func _process(delta: float) -> void:
	process_movement(delta)
	check_remove()

func process_movement(delta) -> void:
	position += velocity * delta

func check_remove() -> void:
	if global_position.x > 1600 or global_position.x < -400 or global_position.y > 1600 or global_position.y < -400:
		queue_free()

func on_hit():
	penetration_count -= 1
	if penetration_count <= 0:
		if bullet_hit_effect_scene:
			var bullet_hit_effect : BulletHitEffect = bullet_hit_effect_scene.instantiate()
			bullet_hit_effect.top_level = true
			bullet_hit_effect.global_position = self.global_position
			GameUtils.get_effect_container(self).add_child(bullet_hit_effect)
		queue_free()
	
