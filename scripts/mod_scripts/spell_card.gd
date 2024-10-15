class_name SpellCard
extends StageScript

var spell_name : String = "[SPELL CARD NAME]"
var total_bonus : int = 10000000
var duration : float = 40.0
var count_capture : int = 0
var count_attempt : int = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func start_spellcard() -> void:
	var displayer : SpellCardDisplayer = GameUtils.get_spell_card_displayer()
	displayer.do_spellcard()

func update_displayer() -> void:
	var displayer : SpellCardDisplayer = GameUtils.get_spell_card_displayer()
	displayer.set_spellcard(self)
