extends Control

onready var quit_button = $Options/Quit
var nonquit = ["Android", "iOS", "HTML5"]

func _ready() -> void:
	if OS.get_name() in nonquit:
		quit_button.visible = false
	Music.play_music("working")

func _on_Start_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.world) != OK:
		push_error("fail to load world")

func _on_Settings_pressed() -> void:
	$SettingsMenu.visible = true

func _on_Achievements_pressed() -> void:
	$AchievementMenu.visible = true

func _on_Quit_pressed() -> void:
	get_tree().quit()
