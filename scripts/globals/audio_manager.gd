extends AudioStreamPlayer

func play_audio(sound: AudioStream) -> void:
	set_stream(sound)
	play()
	#audio_node = AudioStreamPlayer2D.new()
	#audio_node.set_stream(audio_shoot)
	#parent.add_child(audio_node)
