extends KinematicBody

var outside_forces: Vector3
var velocity: Vector3
var gravity = -30
var moving := true
var path := PoolVector3Array() setget set_path
var path_node := 0
var speed := 10
onready var nav = get_parent()
onready var player = $"../../Player"

func _ready() -> void:
	pass

func set_path(value: PoolVector3Array) -> void:
	path = value
	if value.size() == 0:
		return
	moving = true

func add_outside_force(force: Vector3) -> void:
	outside_forces += force
	outside_forces += Vector3.UP * 5
	print(outside_forces)

func _physics_process(delta) -> void:
	velocity.y += gravity * delta
	velocity += outside_forces
	velocity = move_and_slide_with_snap(velocity, Vector3(0,velocity.y,0), Vector3.UP, true)
	outside_forces = Vector3.ZERO
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			var _velocity = move_and_slide(direction.normalized() * speed, Vector3.UP)

func move_to(target_pos) -> void:
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0
