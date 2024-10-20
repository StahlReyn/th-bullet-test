extends MovementScript

@export var spin_speed : float = 10 ## deg/s

func _physics_process(delta: float) -> void:
	parent.rotation += delta * spin_speed
