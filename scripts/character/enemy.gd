class_name Enemy
extends Character

func do_death():
	print("DEATH!")
	if audio_death:
		audio_death.play()
	queue_free()
