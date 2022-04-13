extends TextureButton

export var identity = "MAIL"
export var icon_texture = preload("res://assets/screen/icons/internet-mail.png")
signal icon_pressed()

func _ready() -> void:
	texture_disabled = icon_texture
	texture_focused = icon_texture
	texture_hover = icon_texture
	texture_normal = icon_texture
	texture_pressed = icon_texture
	if connect("pressed", self, "_on_pressed") != OK:
		push_error("icon press connect fail")

func _on_pressed() -> void:
	emit_signal("icon_pressed")
	texture_disabled = icon_texture
	texture_focused = icon_texture
	texture_hover = icon_texture
	texture_normal = icon_texture
	texture_pressed = icon_texture
