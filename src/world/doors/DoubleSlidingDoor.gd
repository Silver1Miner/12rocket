extends Spatial

export var is_closed = true
export var requires_key = false

func on_looked_at() -> void:
	open_double()

func open_double() -> void:
	if requires_key and not PlayerData.has_key:
		return
	if is_closed:
		$SlidingDoor/AnimationPlayer.play("open")
		$SlidingDoor2/AnimationPlayer.play("open")
		$Timer.start()

func close_double() -> void:
	if not is_closed:
		$SlidingDoor/AnimationPlayer.play("close")
		$SlidingDoor2/AnimationPlayer.play("close")
	else:
		$Timer.start()

func _on_Timer_timeout() -> void:
	close_double()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "open":
		is_closed = false
	elif anim_name == "close":
		is_closed = true
