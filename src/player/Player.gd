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
var jump_speed = 8
export var in_screen = false
export var has_rocket_launcher = false

func _ready() -> void:
	if !in_screen:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	yield(get_tree().create_timer(1.0), "timeout")
	$HUD.show_move_instructions()

func get_input():
	if in_screen:
		return Vector3.ZERO
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
		$HUD/Pause.activate()
	if event.is_action_pressed("ui_select"):
		if in_screen:
			return
		elif Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().set_input_as_handled()
	if event.is_action_pressed("shoot"):
		if has_rocket_launcher:
			$Pivot/RocketLauncher.shoot()
		else:
			interact()
			get_tree().set_input_as_handled()
	if event.is_action_pressed("interact"):
		interact()
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
	velocity = move_and_slide_with_snap(velocity, Vector3(0,velocity.y,0), Vector3.UP, true)
	check_raycast()

func check_raycast():
	if _raycast.is_colliding():
		var target = _raycast.get_collider()
		if target.has_method("get_description"):
			$HUD.update_label(target.get_description())
		if target.get_parent() and target.get_parent().has_method("on_looked_at"):
			target.get_parent().on_looked_at()
			if target.get_parent().has_method("get_description"):
				$HUD.update_label(target.get_parent().get_description())
	else:
		$HUD.update_label("")

func interact():
	if _raycast.is_colliding():
		var target = _raycast.get_collider()
		if target and target.get("prop_name"):
			if target.prop_name == "Computer":
				enter_screen()
			elif target.prop_name == "Rocket":
				has_rocket_launcher = true
				target.on_Player_interact()
		elif target.has_method("on_Player_interact"):
			target.on_Player_interact()
		else:
			print("play interact fail sound here")

func _on_Pause_unpaused() -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func enter_screen() -> void:
	in_screen = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Music.play_sound("logon")
	$HUD/Screen.visible = true

func _on_Screen_logout() -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	in_screen = false
	if PlayerData.see_advanced_move:
		$HUD.show_move_advanced_instructions()
		PlayerData.see_advanced_move = false

func end_game() -> void:
	$HUD.exit_game()

func _on_Screen_advance_knowledge() -> void:
	PlayerData.ending_choice = 1
	end_game()

func play_audio_cue(audio_id) -> void:
	$Cue.stream = audio_cues[audio_id]
	$Cue.play()

var audio_cues = [
	preload("res://assets/audio/cues/footstep00.ogg"),
]
