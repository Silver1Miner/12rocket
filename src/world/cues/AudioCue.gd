extends Area

export var active := true
export var audio_id = 0

func _on_AudioCue_body_entered(body: Node) -> void:
	if active and body.is_in_group("player"):
		randomize()
		if rand_range(1, 5) > 4:
			active = false
			body.play_audio_cue(audio_id)
