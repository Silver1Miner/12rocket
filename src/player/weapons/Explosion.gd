extends Spatial

export var damage = 80

func _ready() -> void:
	$CPUParticles.emitting = true
	$AudioStreamPlayer3D.play()
	$Timer.start()
	apply_force()

func _on_AudioStreamPlayer3D_finished() -> void:
	queue_free()

func _on_Area_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)

func _on_Timer_timeout() -> void:
	$AudioStreamPlayer3D.stop()
	queue_free()

func apply_force() -> void:
	var targets = $Area.get_overlapping_bodies()
	for target in targets:
		if target.is_in_group("enemy"):
			var force_vector = get_global_transform().basis.y
			var pos = get_global_transform().origin
			target.add_force(force_vector, pos)
		
