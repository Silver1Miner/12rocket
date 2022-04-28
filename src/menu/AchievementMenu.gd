extends ColorRect

var elevator = preload("res://assets/screen/icons/system-log-out.png")
var rocket = preload("res://assets/screen/icons/user-trash.png")
var paradox = preload("res://assets/screen/icons/software-update-urgent.png")
var speedrun = preload("res://assets/screen/icons/appointment-new.png")
var lock = preload("res://assets/screen/icons/emblem-readonly.png")

func _ready() -> void:
	visible = false

func _on_Close_pressed() -> void:
	visible = false

func activate() -> void:
	if PlayerData.did_elevator:
		$Achievements/AchievementIcon/Icon.texture = elevator
	else:
		$Achievements/AchievementIcon/Icon.texture = lock
		$Achievements/AchievementIcon.modulate = Color(150.0/255,150.0/255,150.0/255)
	if PlayerData.did_rocket:
		$Achievements/AchievementIcon2/Icon.texture = rocket
	else:
		$Achievements/AchievementIcon2/Icon.texture = lock
		$Achievements/AchievementIcon2.modulate = Color(150.0/255,150.0/255,150.0/255)
	if PlayerData.did_paradox:
		$Achievements/AchievementIcon3/Icon.texture = paradox
	else:
		$Achievements/AchievementIcon3/Icon.texture = lock
		$Achievements/AchievementIcon3.modulate = Color(150.0/255,150.0/255,150.0/255)
	if PlayerData.did_speedrun:
		$Achievements/AchievementIcon4/Icon.texture = speedrun
	else:
		$Achievements/AchievementIcon4/Icon.texture = lock
		$Achievements/AchievementIcon4.modulate = Color(150.0/255,150.0/255,150.0/255)
	visible = true
