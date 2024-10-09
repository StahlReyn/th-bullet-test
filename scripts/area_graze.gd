class_name AreaGraze
extends Area2D

signal graze

@onready var focus_sprite : Sprite2D = $FocusDot
@onready var graze_sprite : Sprite2D = $GrazeCircle
@onready var audio_graze : AudioStreamPlayer2D = $AudioGraze

var focus_transition_speed : float = 20.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	graze_sprite.rotation += delta
	if Input.is_action_pressed("focus"):
		graze_sprite.scale = lerp(graze_sprite.scale, Vector2(2,2), delta * focus_transition_speed)
		graze_sprite.set_modulate(lerp(graze_sprite.get_modulate(), Color(1,1,1,0.5), delta * focus_transition_speed))
		focus_sprite.set_modulate(lerp(focus_sprite.get_modulate(), Color(1,1,1,1), delta * focus_transition_speed))
	else:
		graze_sprite.scale = lerp(graze_sprite.scale, Vector2(2.5,2.5), delta * focus_transition_speed)
		graze_sprite.set_modulate(lerp(graze_sprite.get_modulate(), Color(1,1,1,0), delta * focus_transition_speed))
		focus_sprite.set_modulate(lerp(focus_sprite.get_modulate(), Color(1,1,1,0), delta * focus_transition_speed))

func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		graze.emit()
		GameUtils.get_game_view(self).graze_count += 1
		audio_graze.play()
