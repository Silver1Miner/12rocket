extends KinematicBody

var outside_forces: Vector3
var velocity: Vector3
var gravity = -60
var moving := true
var path := PoolVector3Array()
var path_node := 0
export var speed := 2
var active = true
onready var nav = get_parent().get_parent()
onready var player = $"../../../Player"
export var hp = 20

signal destroyed()

func _ready() -> void:
	if not player or not nav:
		active = false

func add_outside_force(force: Vector3) -> void:
	outside_forces += force
	outside_forces += Vector3.UP * 10
	path_node = 0
	path = PoolVector3Array()
	print(outside_forces)

func _physics_process(delta) -> void:
	var direction = Vector3.ZERO
	if active and path_node < path.size():
		direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			velocity = move_and_slide(direction.normalized() * speed, Vector3.UP)
	velocity.y += gravity * delta
	velocity += outside_forces
	velocity = move_and_slide(velocity, Vector3.UP)
	outside_forces = Vector3.ZERO
	attack_damage()

func move_to(target_pos) -> void:
	$Mesh.look_at(Vector3(target_pos.x,global_transform.origin.y,target_pos.z), Vector3.UP)
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _on_Timer_timeout() -> void:
	if active:
		move_to(player.global_transform.origin)

func take_damage(damage: int) -> void:
	hp = clamp(hp - damage, 0, 20)
	if hp <= 0:
		emit_signal("destroyed")
		queue_free()

func attack_damage() -> void:
	for b in $Mesh/DamageBox.get_overlapping_bodies():
		if b.is_in_group("player") and b.has_method("take_damage"):
			b.take_damage(1)
