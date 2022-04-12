extends Window

onready var _unlock = $Unlock
onready var _feed = $VideoFeed/Feed
export var unlock_target = 0
onready var _target_display = $Unlock/Instructions/Target
onready var _camera2status = $Unlock/UnlockChoice/CameraState2
onready var _camera3status = $Unlock/UnlockChoice/CameraState3
onready var _doorstate2 = $Unlock/UnlockChoice/DoorState2

func _ready() -> void:
	update_lock_status()

func _on_CameraUnlock_pressed() -> void:
	_unlock.visible = true

func _on_Camera1_pressed() -> void:
	_feed.texture =PlayerData.camera_feed[0]

func _on_Camera2_pressed() -> void:
	if PlayerData.camera2_unlocked:
		_feed.texture =PlayerData.camera_feed[1]

func _on_Camera3_pressed() -> void:
	if PlayerData.camera3_unlocked:
		_feed.texture =PlayerData.camera_feed[2]

func _on_CameraUnlock2_pressed() -> void:
	unlock_target = 0
	update_target_display()

func _on_CameraUnlock3_pressed() -> void:
	unlock_target = 1
	update_target_display()

func _on_DoorUnlock2_pressed() -> void:
	unlock_target = 2
	update_target_display()

var target_choices = ["Camera 2", "Camera 3", "Door 1"]
func update_target_display() -> void:
	_target_display.text = target_choices[unlock_target]

func update_lock_status() -> void:
	if PlayerData.unlocked_doors[0]:
		_doorstate2.text = "UNLOCKED"
	else:
		_doorstate2.text = "*locked*"
	if PlayerData.camera2_unlocked:
		_camera2status.text = "UNLOCKED"
	else:
		_camera2status.text = "*locked*"
	if PlayerData.camera3_unlocked:
		_camera3status.text = "UNLOCKED"
	else:
		_camera3status.text = "*locked*"

func _on_NumLock_check_value(current_value) -> void:
	match unlock_target:
		0:
			if current_value == PlayerData.unlock_codes[0]:
				PlayerData.camera2_unlocked = true
		1:
			if current_value == PlayerData.unlock_codes[1]:
				PlayerData.camera3_unlocked = true
		2:
			if current_value == PlayerData.unlock_codes[2]:
				PlayerData.unlocked_doors[0] = true
	update_lock_status()
