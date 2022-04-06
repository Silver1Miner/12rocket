extends ColorRect

signal unpaused()

func _ready() -> void:
	visible = false

func activate() -> void:
	get_tree().paused = true
	visible = true

func _on_Resume_pressed() -> void:
	get_tree().paused = false
	visible = false
	emit_signal("unpaused")

func _on_MainMenu_pressed() -> void:
	get_tree().paused = false
	if get_tree().change_scene_to(PlayerData.main_menu) != OK:
		push_error("fail to load main menu")
