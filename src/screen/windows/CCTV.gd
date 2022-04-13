extends Window

onready var _unlock = $Unlock
onready var _feed = $VideoFeed/Feed
export var unlock_target = 0
onready var _target_display = $Unlock/Instructions/Target
onready var _camera2status = $Unlock/UnlockChoice/CameraState2
onready var _camera3status = $Unlock/UnlockChoice/CameraState3
onready var _doorstate1 = $Unlock/UnlockChoice/DoorState1
onready var _doorstate2 = $Unlock/UnlockChoice/DoorState2
onready var _camera2 = $VideoFeed/CameraChoice/Camera2
onready var _camera3 = $VideoFeed/CameraChoice/Camera3

signal camera_used(camera_id)

func _ready() -> void:
	update_lock_status()

func _on_CameraUnlock_pressed() -> void:
	_unlock.visible = true

func _on_Camera1_pressed() -> void:
	_feed.texture =PlayerData.camera_feed[0]

func _on_Camera2_pressed() -> void:
	if PlayerData.camera2_unlocked:
		_feed.texture =PlayerData.camera_feed[1]
		emit_signal("camera_used", 2)

func _on_Camera3_pressed() -> void:
	if PlayerData.camera3_unlocked:
		_feed.texture =PlayerData.camera_feed[2]
		emit_signal("camera_used", 3)

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

var target_choices = ["Camera 2", "Camera 3", "Door 1", "Door 2"]
func update_target_display() -> void:
	_target_display.text = target_choices[unlock_target]

func update_lock_status() -> void:
	if PlayerData.unlocked_doors[0]:
		_doorstate1.text = "UNLOCKED"
	else:
		_doorstate1.text = "*locked*"
	if PlayerData.unlocked_doors[1]:
		_doorstate2.text = "UNLOCKED"
	else:
		_doorstate2.text = "*locked*"
	if PlayerData.camera2_unlocked:
		_camera2status.text = "UNLOCKED"
		_camera2.disabled = false
	else:
		_camera2status.text = "*locked*"
		_camera2.disabled = true
	if PlayerData.camera3_unlocked:
		_camera3status.text = "UNLOCKED"
		_camera3.disabled = false
	else:
		_camera3status.text = "*locked*"
		_camera3.disabled = true

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
		3:
			if current_value == PlayerData.unlock_codes[3]:
				PlayerData.unlocked_doors[1] = true
	update_lock_status()


