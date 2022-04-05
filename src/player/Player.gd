extends KinematicBody

onready var _raycast = $Pivot/RayCast
onready var camera = $Pivot/Camera
var gravity = -30
var max_speed = 5
var sprint_multiplier = 2
var mouse_sensitivity = 0.002
var velocity = Vector3()
var is_jumping = false
var is_sprinting = false
var jump_speed = 6
export var in_screen = false

func _ready() -> void:
	if !in_screen:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("ui_up"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("ui_down"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("ui_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("ui_right"):
		input_dir += global_transform.basis.x
	is_jumping = false
	if Input.is_action_just_pressed("jump"):
		is_jumping = true
	if Input.is_action_pressed("sprint"):
		is_sprinting = true
	else:
		is_sprinting = false
	input_dir = input_dir.normalized()
	return input_dir

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("ui_select"):
		if in_screen:
			return
		elif Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().set_input_as_handled()

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)

func _physics_process(delta):
	if is_jumping and is_on_floor():
		velocity.y = jump_speed
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	if is_sprinting:
		desired_velocity *= sprint_multiplier
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	check_raycast()

func check_raycast():
	if _raycast.is_colliding():
		var target = _raycast.get_collider()
		if target.has_method("get_name"):
			$HUD.update_label(target.get_name())
	else:
		$HUD.update_label("Nothing")
