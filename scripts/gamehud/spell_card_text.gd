extends Node2D

@onready var animation_node : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	do_spellcard()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func do_spellcard() -> void:
	animation_node.play("start")
	AudioManager.play_spell_card()

func end_spellcard() -> void:
	animation_node.play("end")
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"start":
			animation_node.play("move")
