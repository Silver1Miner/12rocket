extends Control

signal logout()

func _on_Logout_icon_pressed() -> void:
	visible = false
	emit_signal("logout")

func _on_Inbox_icon_pressed() -> void:
	print("open messages")
