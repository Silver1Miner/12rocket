extends Control

onready var quit_button = $Options/Quit
var nonquit = ["Android", "iOS", "HTML5"]

func _ready() -> void:
	if OS.get_name() in nonquit:
		quit_button.visible = false

func _on_Start_pressed() -> void:
	print("new game")

func _on_Settings_pressed() -> void:
	print("settings")

func _on_Achievements_pressed() -> void:
	print("achievements")

func _on_Quit_pressed() -> void:
	get_tree().quit()
