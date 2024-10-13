extends MovementScript

func process_movement(delta: float) -> void:
	var velocity = Vector2()
	velocity.x += sin(parent.total_time * 3) * 400
	velocity.y += 100
	parent.position += velocity * delta
	parent.process_animation(velocity)
