extends Control

onready var _label = $Status/Label
onready var _animation_player = $Status/AnimationPlayer

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

