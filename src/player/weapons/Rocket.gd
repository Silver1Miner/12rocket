extends Spatial

export var projectile_speed = 10
export var explosion = preload("res://src/player/weapons/Explosion.tscn")
var timer = 0
var kill_timer = 8

func _physics_process(delta: float) -> void:
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * projectile_speed * delta)
	timer += delta
	if timer >= kill_timer:
		queue_free()

func _on_Area_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		explode()

func explode() -> void:
	var explosion_instance = explosion.instance()
	explosion_instance.global_transform = global_transform
	get_parent().add_child(explosion_instance)
	queue_free()
