extends StaticBody
class_name Prop

export var prop_name = "Block"
export var prop_description = "A generic block prop"

func get_name() -> String:
	return prop_name

func on_Player_interact() -> void:
	print("player interacted with ", prop_name)

func get_description() -> String:
	if visible:
		return prop_description
	return ""
