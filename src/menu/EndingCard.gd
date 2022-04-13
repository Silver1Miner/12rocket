extends Control

onready var fade_animation = $Fade/AnimationPlayer

func _ready() -> void:
	if PlayerData.ending_choice == 1:
		$Label.text = "ENDING1"
	else:
		$Label.text = "ENDING2"
	fade_animation.play("fade")

func _on_Button_pressed() -> void:
	fade_animation.play_backwards("fade")
	yield(fade_animation, "animation_finished")
	if get_tree().change_scene_to(PlayerData.main_menu) != OK:
		push_error("failed to go to main menu")
