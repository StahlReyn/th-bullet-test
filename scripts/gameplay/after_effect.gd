class_name AfterEffect
extends Node2D
## Things after enemy or bullet is removed, like death effects

@export var audio_start : AudioStreamPlayer2D
@export var lifetime : float = 1.0

func _ready() -> void:
	audio_start.play()
	await get_tree().create_timer(lifetime).timeout
	queue_free()

static func add_effect(scene : PackedScene, target : Node2D):
	var effect : AfterEffect = scene.instantiate()
	effect.top_level = true
	effect.global_position = target.global_position
	GameUtils.get_effect_container().add_child(effect)
