extends VBoxContainer

export var current_value = "0000"
onready var _label = $Panel/Label

signal check_value(current_value)

func _ready() -> void:
	_on_Clear_pressed()

func update_label() -> void:
	_label.text = current_value

func _on_1_pressed() -> void:
	current_value = current_value.substr(1,3) + "1"
	update_label()

func _on_2_pressed() -> void:
	current_value = current_value.substr(1,3) + "2"
	update_label()

func _on_3_pressed() -> void:
	current_value = current_value.substr(1,3) + "3"
	update_label()

func _on_4_pressed() -> void:
	current_value = current_value.substr(1,3) + "4"
	update_label()

func _on_5_pressed() -> void:
	current_value = current_value.substr(1,3) + "5"
	update_label()

func _on_6_pressed() -> void:
	current_value = current_value.substr(1,3) + "6"
	update_label()

func _on_7_pressed() -> void:
	current_value = current_value.substr(1,3) + "7"
	update_label()

func _on_8_pressed() -> void:
	current_value = current_value.substr(1,3) + "8"
	update_label()

func _on_9_pressed() -> void:
	current_value = current_value.substr(1,3) + "9"
	update_label()

func _on_0_pressed() -> void:
	current_value = current_value.substr(1,3) + "0"
	update_label()

func _on_Clear_pressed() -> void:
	current_value = "0000"
	update_label()

func _on_Enter_pressed() -> void:
	emit_signal("check_value", current_value)
