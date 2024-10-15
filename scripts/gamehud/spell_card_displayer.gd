class_name SpellCardDisplayer
extends Node2D

@onready var animation_node : AnimationPlayer = $AnimationPlayer
@onready var label_name : Label = $FullDisplay/SpellCardName/LabelName
@onready var label_timer : Label = $LabelTimer

var cur_spellcard : SpellCard

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if cur_spellcard:
		label_name.text = cur_spellcard.spell_name

func do_spellcard() -> void:
	animation_node.play("start")
	AudioManager.play_spell_card()

func end_spellcard() -> void:
	animation_node.play("end")
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"start":
			animation_node.play("move")

func set_spellcard(spellcard : SpellCard):
	cur_spellcard = spellcard
	
