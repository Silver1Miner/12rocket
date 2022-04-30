extends StaticBody

export var prop_description = ""

func get_description() -> String:
	if visible:
		return prop_description
	return ""
