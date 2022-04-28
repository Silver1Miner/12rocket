extends Node

var did_elevator = false
var did_rocket = false
var did_paradox = false
var did_speedrun = false

var world = preload("res://src/world/World.tscn")
var main_menu = preload("res://src/menu/MainMenu.tscn")
var ending = preload("res://src/menu/EndingCard.tscn")
var arena = preload("res://src/arena/Arena.tscn")
var music_db = 0.2
var sound_db = 0.1

var game_started := false
var camera2_unlocked := false
var camera3_unlocked := false
var see_advanced_move := false
var got_first_code := false
var unlocked_doors = [false, false]
var ending_choice := 0
var game_route := 2
var previous_route := 0

var camera_feed = [
	preload("res://assets/screen/video/hall-view.PNG"),
	preload("res://assets/screen/video/lab-view1.PNG"),
	preload("res://assets/screen/video/lab-view2.PNG"),
	preload("res://assets/screen/video/warning.jpg"),
	preload("res://assets/screen/video/lab-gnome.jpg"),
	preload("res://assets/screen/video/hall-view-2.PNG")
]

var unlock_codes = [
	["1234","2345","3456"],
	["8128","8128","8128"],
	["0451","0451","0451"],
	["6174","6174","6174"],
]

func _ready() -> void:
	load_player_data()

func reset() -> void:
	game_started = false
	camera2_unlocked = false
	camera3_unlocked = false
	unlocked_doors = [false, false]
	see_advanced_move = false
	got_first_code = false
	ending_choice = 0
	previous_route = game_route
	if game_route < 2:
		game_route += 1
	else:
		game_route = 0

func load_player_data() -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://rocket.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://rocket.save", File.READ)
	music_db = parse_json(save_game.get_line())
	sound_db = parse_json(save_game.get_line())
	did_elevator = parse_json(save_game.get_line())
	did_rocket = parse_json(save_game.get_line())
	did_paradox = parse_json(save_game.get_line())
	did_speedrun = parse_json(save_game.get_line())
	save_game.close()

func save_player_data() -> void:
	var save_game = File.new()
	save_game.open("user://rocket.save", File.WRITE)
	save_game.store_line(to_json(music_db))
	save_game.store_line(to_json(sound_db))
	save_game.store_line(to_json(did_elevator))
	save_game.store_line(to_json(did_rocket))
	save_game.store_line(to_json(did_paradox))
	save_game.store_line(to_json(did_speedrun))
	save_game.close()
