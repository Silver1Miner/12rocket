extends Window

onready var _unlock = $Unlock
onready var _feed = $VideoFeed/Feed
onready var _feed_cover = $VideoFeed/Feed/Cover
export var unlock_target = 0
onready var _target_display = $Unlock/Instructions/Target
onready var _camera2status = $Unlock/UnlockChoice/CameraState2
onready var _camera3status = $Unlock/UnlockChoice/CameraState3
onready var _doorstate1 = $Unlock/UnlockChoice/DoorState1
onready var _doorstate2 = $Unlock/UnlockChoice/DoorState2
onready var _camera2 = $VideoFeed/CameraChoice/Camera2
onready var _camera3 = $VideoFeed/CameraChoice/Camera3
onready var _camera2choice = $Unlock/UnlockChoice/CameraUnlock2
onready var _camera3choice = $Unlock/UnlockChoice/CameraUnlock3
onready var _door1choice = $Unlock/UnlockChoice/DoorUnlock1
onready var _door2choice = $Unlock/UnlockChoice/DoorUnlock2

signal camera_used(camera_id)
signal advance_knowledge()

func _ready() -> void:
	update_lock_status()

func _on_close_pressed() -> void:
	_feed.texture = PlayerData.camera_feed[0]
	visible = false

func _on_CameraUnlock_pressed() -> void:
	_unlock.visible = true

var current_camera := 0
func _on_Camera1_pressed() -> void:
	_feed_cover.visible = false
	emit_signal("camera_used", 1)
	if current_camera == 1:
		return
	randomize()
	if rand_range(1,10) < 9:
		_feed.texture = PlayerData.camera_feed[0]
	else:
		_feed.texture = PlayerData.camera_feed[5]
	current_camera = 1

func _on_Camera2_pressed() -> void:
	if PlayerData.camera2_unlocked:
		emit_signal("camera_used", 2)
		if current_camera == 2:
			return
		current_camera = 2
		if PlayerData.unlocked_doors[0]:
			_feed.texture = PlayerData.camera_feed[2]
		else:
			_feed.texture = PlayerData.camera_feed[1]
		_feed_cover.visible = false
	else:
		Music.play_sound("error")

var camera_3_used = false
func _on_Camera3_pressed() -> void:
	if PlayerData.camera3_unlocked:
		emit_signal("camera_used", 3)
		if current_camera == 3:
			return
		current_camera = 3
		if camera_3_used:
			_feed.texture = PlayerData.camera_feed[4]
		else:
			_feed.texture = PlayerData.camera_feed[3]
			camera_3_used = true
		_feed_cover.visible = false
	else:
		Music.play_sound("error")

func _on_CameraUnlock2_pressed() -> void:
	unlock_target = 0
	update_target_display()

func _on_CameraUnlock3_pressed() -> void:
	unlock_target = 1
	update_target_display()

func _on_DoorUnlock1_pressed() -> void:
	unlock_target = 2
	update_target_display()

func _on_DoorUnlock2_pressed() -> void:
	unlock_target = 3
	update_target_display()

var target_choices = ["Camera 2", "Camera 3", "Lab 46", "Lounge"]
func update_target_display() -> void:
	_target_display.text = target_choices[unlock_target]

func update_lock_status() -> void:
	if PlayerData.unlocked_doors[0]:
		_doorstate1.text = "UNLOCKED"
		_door1choice.disabled = true
	else:
		_doorstate1.text = "*locked*"
		_door1choice.disabled = false
	if PlayerData.unlocked_doors[1]:
		_doorstate2.text = "UNLOCKED"
		_door2choice.disabled = true
	else:
		_doorstate2.text = "*locked*"
		_door2choice.disabled = false
	if PlayerData.camera2_unlocked:
		_camera2status.text = "UNLOCKED"
		_camera2.disabled = false
		_camera2choice.disabled = true
	else:
		_camera2status.text = "*locked*"
		_camera2.disabled = true
		_camera2choice.disabled = false
	if PlayerData.camera3_unlocked:
		_camera3status.text = "UNLOCKED"
		_camera3.disabled = false
		_camera3choice.disabled = true
	else:
		_camera3status.text = "*locked*"
		_camera3.disabled = true
		_camera3choice.disabled = false

func _on_NumLock_check_value(current_value) -> void:
	match unlock_target:
		0:
			if current_value == PlayerData.unlock_codes[0][PlayerData.game_route]:
				#if PlayerData.got_first_code:
				PlayerData.camera2_unlocked = true
				Music.play_sound("unlock")
				#else:
				#	emit_signal("advance_knowledge")
			elif current_value == PlayerData.unlock_codes[0][PlayerData.previous_route]:
				emit_signal("advance_knowledge")
				Music.play_sound("error")
			else:
				Music.play_sound("error")
		1:
			if current_value == PlayerData.unlock_codes[1][PlayerData.game_route]:
				if PlayerData.unlocked_doors[0]:
					PlayerData.camera3_unlocked = true
					Music.play_sound("unlock")
				else:
					emit_signal("advance_knowledge")
			else:
				Music.play_sound("error")
		2:
			if current_value == PlayerData.unlock_codes[2][PlayerData.game_route]:
				if PlayerData.camera2_unlocked:
					PlayerData.unlocked_doors[0] = true
					Music.play_sound("unlock")
					PlayerData.see_advanced_move = true
				else:
					emit_signal("advance_knowledge")
			else:
				Music.play_sound("error")
		3:
			if current_value == PlayerData.unlock_codes[3][PlayerData.game_route]:
				PlayerData.unlocked_doors[1] = true
				Music.play_sound("unlock")
			else:
				Music.play_sound("error")
	update_lock_status()


