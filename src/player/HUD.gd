extends Control

onready var _label = $Status/Label
onready var _animation_player = $Status/AnimationPlayer
onready var transition = $Transition/AnimationPlayer
onready var damage_flash = $Combat/DamageColor/AnimationPlayer

func _ready() -> void:
	$Status/Move.visible = false
	$Status/MoveAdvanced.visible = false

func enter_combat_view() -> void:
	$Combat.visible = true

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

var previous_hp = 100
func update_hp(hp: int) -> void:
	$Combat/HP.text = "HP: " + str(hp)
	if hp < previous_hp:
		damage_flash.play("damage_flash")
	elif hp > previous_hp:
		damage_flash.play("heal_flash")
	previous_hp = hp

func update_ammo(ammo: int) -> void:
	$Combat/Ammo.text = str(ammo)

func update_sprint(sprint) -> void:
	$SprintProgress.value = sprint
	if sprint == 100:
		$SprintProgress.visible = false
	else:
		$SprintProgress.visible = true
