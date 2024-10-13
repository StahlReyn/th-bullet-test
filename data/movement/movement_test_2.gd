extends MovementScript

func process_movement(delta: float) -> void:
	var velocity = Vector2()
	velocity.x += cos(parent.total_time * 3) * 300
	velocity.y += sin(parent.total_time * 3) * 300 + 100
	parent.position += velocity * delta
	parent.update_animation(velocity)
