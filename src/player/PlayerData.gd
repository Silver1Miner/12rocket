extends Node

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
	preload("res://assets/screen/video/hall-view-gnome.jpg")
]

var unlock_codes = [
	["1234","2345","3456"],
	["8128","8128","8128"],
	["0451","0451","0451"],
	["6174","6174","6174"],
]

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
