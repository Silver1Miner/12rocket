extends KinematicBody

onready var _raycast = $Pivot/RayCast
onready var camera = $Pivot/Camera
var gravity = -30
var max_speed = 4
var sprint_multiplier = 3
var mouse_sensitivity = 0.002
var velocity = Vector3()
var is_jumping = false
var is_sprinting = false
var jump_speed = 8
export var in_screen = false
export var has_rocket_launcher = false
var outside_forces: Vector3
export var hp = 100
export var ammo = 10
export var rocket_limit = false
export var sprint = 100

func _ready() -> void:
	if !in_screen:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if has_rocket_launcher:
		$HUD.enter_combat_view()
		$Pivot/RocketLauncher.visible = true
	else:
		$Pivot/RocketLauncher.visible = false
	yield(get_tree().create_timer(1.0), "timeout")
	$HUD.show_move_instructions()

func add_outside_force(force: Vector3):
	outside_forces += force

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
			$HUD.update_ammo($Pivot/RocketLauncher.ammo)
			if rocket_limit and $Pivot/RocketLauncher.ammo == 0:
				PlayerData.ending_choice = 2
				end_game()
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
		if sprint > 0:
			desired_velocity *= sprint_multiplier
		sprint = clamp(sprint - 2, 0, 100)
	else:
		sprint = clamp(sprint + 1, 0, 100)
	$HUD.update_sprint(sprint)
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity += outside_forces
	velocity = move_and_slide_with_snap(velocity, Vector3(0,velocity.y,0), Vector3.UP, true)
	check_raycast()
	outside_forces = Vector3.ZERO

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
				$HUD.enter_combat_view()
				$Pivot/RocketLauncher.visible = true
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
	if not $SpeedrunTimer.is_stopped():
		print($SpeedrunTimer.time_left)
		PlayerData.did_speedrun = true
	match PlayerData.ending_choice:
		0:
			PlayerData.did_elevator = true
		1:
			PlayerData.did_paradox = true
		2:
			PlayerData.did_rocket = true
		3:
			PlayerData.did_rocket = true
	$HUD.exit_game()
	PlayerData.save_player_data()

func _on_Screen_advance_knowledge() -> void:
	PlayerData.ending_choice = 1
	end_game()

func play_audio_cue(audio_id) -> void:
	if not $Cue.playing:
		$Cue.stream = audio_cues[audio_id]
		$Cue.play()

var audio_cues = [
	preload("res://assets/audio/cues/footstep00.ogg"),
	preload("res://assets/audio/cues/gasp1.ogg"),
	preload("res://assets/audio/cues/laugh1.ogg"),
	preload("res://assets/audio/cues/scared-breathing.ogg"),
	preload("res://assets/audio/cues/freakedbreath.ogg"),
	preload("res://assets/audio/effects/confirmation_004.ogg"),
	preload("res://assets/audio/effects/shotguncock.wav")
]

func take_damage(damage: int) -> void:
	hp = clamp(hp - damage, 0, 100)
	$HUD.update_hp(hp)
	play_audio_cue(4)
	if hp <= 0:
		PlayerData.ending_choice = 3
		end_game()

func restore_health(health: int) -> void:
	hp = clamp(hp + health, 0, 100)
	play_audio_cue(5)
	$HUD.update_hp(hp)

func restore_ammo(value: int) -> void:
	$Pivot/RocketLauncher.ammo = clamp($Pivot/RocketLauncher.ammo + value, 0, 20)
	$HUD.update_ammo($Pivot/RocketLauncher.ammo)
	play_audio_cue(6)
