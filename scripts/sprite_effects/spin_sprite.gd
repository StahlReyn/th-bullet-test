extends Sprite2D

@export var spin_speed : float = 10 ## deg/s

func _physics_process(delta: float) -> void:
	rotation += delta * spin_speed
