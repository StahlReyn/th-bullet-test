class_name ItemCollectDisplay
extends Node2D

static var item_scene : PackedScene = preload("res://scripts/items/item_collect_display.tscn")

@onready var label : Label = $Label
var up_speed : float = 50.0
var fade_speed : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_text("")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var color : Color = get_modulate()
	color.a -= fade_speed * delta
	set_modulate(color) # Fade out
	position.y -= up_speed * delta
	if color.a <= 0:
		call_deferred("queue_free")
	pass

func set_text(text: String) -> void:
	label.text = text

func set_maximum_style() -> void:
	var color : Color = get_modulate()
	color.b = 0;
	set_modulate(color) # Set Yellow
