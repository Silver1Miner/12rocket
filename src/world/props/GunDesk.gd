extends Prop

func on_Player_interact() -> void:
	emit_signal("interacted")
	$rocketlauncherModern.visible = false
