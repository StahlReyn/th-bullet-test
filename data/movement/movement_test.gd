extends MovementScript

func process_movement(delta: float) -> void:
	parent.velocity.x = sin(parent.total_time * 3) * 400
	parent.velocity.y = 100
