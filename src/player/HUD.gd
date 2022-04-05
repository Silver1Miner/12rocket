extends Control

onready var _label = $Status/Label

func update_label(new_text: String) -> void:
	_label.text = new_text

