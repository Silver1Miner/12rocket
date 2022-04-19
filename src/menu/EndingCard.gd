extends Control

onready var fade_animation = $Fade/AnimationPlayer
var ending_cards := [
	preload("res://assets/ending/message-small.PNG"),
	preload("res://assets/ending/news-clip.PNG"),
	preload("res://assets/ending/tragedy.PNG")
]


func _ready() -> void:
	if PlayerData.ending_choice == 1:
		$Label.text = "Time Paradox Ending"
		$TextureRect.texture = ending_cards[0]
	elif PlayerData.ending_choice == 2:
		$Label.text = "Rocket Launcher Ending"
		$TextureRect.texture = ending_cards[2]
	else:
		$Label.text = "Elevator Ending"
		$TextureRect.texture = ending_cards[1]
	fade_animation.play("fade")

func _on_Button_pressed() -> void:
	fade_animation.play_backwards("fade")
	yield(fade_animation, "animation_finished")
	if get_tree().change_scene_to(PlayerData.main_menu) != OK:
		push_error("failed to go to main menu")
