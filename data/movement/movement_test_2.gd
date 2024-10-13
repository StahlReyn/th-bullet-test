extends MovementScript

func process_movement(delta: float) -> void:
	parent.velocity.x = cos(parent.total_time * 3) * 300
	parent.velocity.y = sin(parent.total_time * 3) * 300 + 100
