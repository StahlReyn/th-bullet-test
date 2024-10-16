class_name DialogueBalloon
extends Node2D

@export var label_main : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_display_text(text: String) -> void:
	label_main.text = text
