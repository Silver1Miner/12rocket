extends Control

onready var _label = $Status/Label
onready var _animation_player = $Status/AnimationPlayer
onready var transition = $Transition/AnimationPlayer

func _ready() -> void:
	$Status/Move.visible = false
	$Status/MoveAdvanced.visible = false

func update_label(new_text: String) -> void:
	_label.text = new_text

func show_move_instructions() -> void:
	_animation_player.play_backwards("MoveFade")
	yield(_animation_player, "animation_finished")
	_animation_player.play("MoveFade")

func show_move_advanced_instructions() -> void:
	_animation_player.play_backwards("MoveAdvanceFade")
	yield(_animation_player, "animation_finished")
	_animation_player.play("MoveAdvanceFade")

func exit_game() -> void:
	transition.play("fade")
	yield(transition, "animation_finished")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if get_tree().change_scene_to(PlayerData.ending) != OK:
		push_error("failed to go to ending")
