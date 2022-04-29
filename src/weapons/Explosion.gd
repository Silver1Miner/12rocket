extends Spatial

export var damage = 20

func _ready() -> void:
	$CPUParticles.emitting = true
	$AudioStreamPlayer3D.play()
	$Timer.start()

func _on_AudioStreamPlayer3D_finished() -> void:
	queue_free()

func _on_Area_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	if body.has_method("add_outside_force"):
		var vector = body.get_global_transform().origin - get_global_transform().origin
		if body.is_in_group("enemy"):
			body.add_outside_force(vector * 5)
		elif body.is_in_group("player"):
			if not body.is_on_floor():
				body.add_outside_force(vector * 10)
			else:
				body.add_outside_force(vector * 2)
	if body.has_method("apply_impulse"):
		var pos = get_global_transform().origin
		var vector = body.get_global_transform().origin - pos
		body.apply_impulse(pos, vector*5)

func _on_Timer_timeout() -> void:
	$AudioStreamPlayer3D.stop()
	queue_free()
