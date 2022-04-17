extends Spatial

export var rocket = preload("res://src/player/weapons/Rocket.tscn")
var can_shoot = true

func shoot() -> void:
	if can_shoot:
		$AudioStreamPlayer3D.play()
		var rocket_instance = rocket.instance()
		rocket_instance.global_transform = global_transform
		get_parent().get_parent().get_parent().add_child(rocket_instance)
		can_shoot = false
		$Timer.start()

func _on_Timer_timeout() -> void:
	can_shoot = true
