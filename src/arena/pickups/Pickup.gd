extends Area
class_name Pickup

export var active = true
export var is_health = true
export var is_ammo = false

func _ready() -> void:
	$AnimationPlayer.play("spin")

func _on_Pickup_body_entered(body: Node) -> void:
	if active and body.is_in_group("player"):
		if is_health and body.has_method("restore_health"):
			if body.hp < 100:
				body.restore_health(50)
				active = false
				$MeshInstance.visible = false
				$Timer.start(10)
		if is_ammo and body.has_method("restore_ammo"):
			if body.get_node("Pivot/RocketLauncher").ammo < 20:
				body.restore_ammo(5)
				active = false
				$MeshInstance.visible = false
				$Timer.start(10)


func _on_Timer_timeout() -> void:
	active = true
	$MeshInstance.visible = true
