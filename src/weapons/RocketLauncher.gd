extends Spatial

export var rocket = preload("res://src/weapons/Rocket.tscn")
var can_shoot = true
onready var muzzle = $Muzzle
onready var aimcast = $RayCast
export var ammo := 3

func shoot() -> void:
	if can_shoot and ammo > 0:
		$AudioStreamPlayer3D.play()
		aimcast.force_raycast_update()
		var rocket_instance = rocket.instance()
		get_parent().get_parent().get_parent().add_child(rocket_instance)
		rocket_instance.global_transform = muzzle.global_transform
		rocket_instance.look_at(aimcast.get_collision_point(), Vector3.UP)
		rocket_instance.rotate_object_local(Vector3(0,1,0), 3.14)
		can_shoot = false
		ammo -= 1
		$Timer.start()

func _on_Timer_timeout() -> void:
	can_shoot = true
