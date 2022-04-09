extends Control

signal logout()

func _ready() -> void:
	if OS.has_environment("USERNAME"):
		$UserID.text = "Logged in as: " + OS.get_environment("USERNAME")
	else:
		$UserID.text = "Logged in as: Remote Connection"

func _on_Logout_icon_pressed() -> void:
	visible = false
	emit_signal("logout")

func _on_ToCalendar_icon_pressed() -> void:
	$Calendar.refresh()
	$Calendar.visible = true

func _on_ToInbox_icon_pressed() -> void:
	$Inbox.visible = true

func _on_ToVideo_pressed() -> void:
	$CCTV.visible = true
