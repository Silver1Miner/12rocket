extends AudioStreamPlayer

onready var tween = $Tween
var previous_name: String = ""

var tracks := {
	"working": preload("res://assets/audio/Working_Music.ogg"),
	"ambient": preload("res://assets/audio/540634__shortrecord__horror-ambient.mp3")
}

# MUSIC
func play_music(music_name: String, start: float = 0) -> void:
	if music_name == previous_name:
		return
	tween.interpolate_property(self, "volume_db", linear2db(PlayerData.music_db), -80, 0.8, 1, Tween.EASE_IN, 0)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property(self, "volume_db", -20, linear2db(PlayerData.music_db), 1.0, 1, Tween.EASE_IN, 0)
	tween.start()
	stream = tracks[music_name] #load(music_path)
	play(start)
	previous_name = music_name
