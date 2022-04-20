extends Control

signal logout()
signal advance_knowledge()

func _ready() -> void:
	if OS.has_environment("USERNAME"):
		$UserID.text = "Logged in as: " + OS.get_environment("USERNAME")
	else:
		$UserID.text = "Logged in as: Remote Connection"

func _on_Logout_icon_pressed() -> void:
	Music.play_sound("logoff")
	visible = false
	emit_signal("logout")

func _on_ToCalendar_icon_pressed() -> void:
	$Calendar.refresh()
	$Calendar.visible = true

func _on_ToInbox_icon_pressed() -> void:
	$Inbox.visible = true

func _on_ToVideo_pressed() -> void:
	$CCTV.visible = true

func _on_Messages_new_message() -> void:
	$Alert.visible = true
	$ToInbox.texture_normal = preload("res://assets/screen/icons/mail-message-new.png")

func _on_Timer_timeout() -> void:
	$Inbox/Messages.new_message()

var c1_unused = true
var c2_unused = true
var c3_unused = true
func _on_CCTV_camera_used(camera_id) -> void:
	if camera_id == 1 and c1_unused:
		c1_unused = false
		randomize()
		$Timer.start(10)
	if camera_id == 2 and c2_unused:
		c2_unused = false
		randomize()
		$Timer.start(rand_range(10,20))
	elif camera_id == 3 and c3_unused:
		c3_unused = false
		randomize()
		$Timer.start(rand_range(10,20))

func _on_ToMessages_pressed() -> void:
	$Alert.visible = false
	$CCTV.visible = false
	$Calendar.visible = false
	$Inbox.visible = true

func _on_CCTV_advance_knowledge() -> void:
	emit_signal("advance_knowledge")
