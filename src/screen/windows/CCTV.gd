extends Window

onready var _unlock = $Unlock

func _ready() -> void:
	pass

func _on_CameraUnlock_pressed() -> void:
	_unlock.visible = true
