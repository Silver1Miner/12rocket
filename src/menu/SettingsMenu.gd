extends ColorRect

var start = false

func _ready() -> void:
	visible = false
	$VolumeControls/MusicVolume.set_value(PlayerData.music_db)
	$VolumeControls/SoundVolume.set_value(PlayerData.sound_db)
	start = true

func _on_Close_pressed() -> void:
	visible = false

func _on_MusicVolume_value_changed(value: float) -> void:
	PlayerData.music_db = value
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"), linear2db(value)
	)

func _on_SoundVolume_value_changed(value: float) -> void:
	PlayerData.sound_db = value
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Sound"), linear2db(value)
	)
	if start:
		Music.play_sound("error")

func _on_CheckBox_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = button_pressed
