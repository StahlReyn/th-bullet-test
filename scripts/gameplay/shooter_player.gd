class_name ShooterPlayer
extends Shooter

@export var position_unfocused : Vector2 = Vector2(0,0)
@export var position_focused : Vector2 = Vector2(0,0)
@export var position_speed : float = 20.0

var player : Player

func _ready() -> void:
	super()
	player = GameUtils.get_player()
	position = position_unfocused
	
func _process(delta: float) -> void:
	super(delta)
	process_position(delta)

func can_shoot() -> bool:
	return player.can_shoot() and cooldown_time <= 0 and Input.is_action_pressed("shoot")

func process_position(delta) -> void:
	if Input.is_action_pressed("focus"):
		position = lerp(position, position_focused, delta * position_speed)
	else:
		position = lerp(position, position_unfocused, delta * position_speed)
