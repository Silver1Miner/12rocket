extends Spatial

export var damage = 80

func _ready() -> void:
	$CPUParticles.emitting = true
	$AudioStreamPlayer3D.play()
	$Timer.start()

func _on_AudioStreamPlayer3D_finished() -> void:
	queue_free()

func _on_Area_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)

func _on_Timer_timeout() -> void:
	$AudioStreamPlayer3D.stop()
	queue_free()
