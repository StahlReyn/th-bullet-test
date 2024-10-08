class_name BulletHitEffect
extends Node2D

@export var audio_hit : AudioStreamPlayer2D
@export var lifetime : float = 1.0

func _ready() -> void:
	audio_hit.play()
	await get_tree().create_timer(lifetime).timeout
	queue_free()
