extends StaticBody
class_name Prop

export var prop_name = "Block"
export var prop_description = "A generic block prop"
signal interacted()

func get_name() -> String:
	return prop_name

func on_Player_interact() -> void:
	emit_signal("interacted")
	print("player interacted with ", prop_name)

func get_description() -> String:
	if visible:
		return prop_description
	return ""
