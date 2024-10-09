class_name Enemy
extends Character

@export var animation_player : AnimationPlayer

func _ready() -> void:
	super()
	if animation_player:
		animation_player.play("default")

func _process(delta: float) -> void:
	super(delta)

func do_death():
	print("DEATH!")
	if audio_death:
		audio_death.play()
	queue_free()
