extends Node

var world = preload("res://src/world/World.tscn")
var main_menu = preload("res://src/menu/MainMenu.tscn")
var ending = preload("res://src/menu/EndingCard.tscn")
var music_db = 0.2
var sound_db = 0.1

var game_started := false
var camera2_unlocked := false
var camera3_unlocked := false
var unlocked_doors = [false, false]
var ending_choice := 0

var camera_feed = [
	preload("res://assets/screen/video/nastuh-abootalebi-rSpMla5RItA-unsplash.jpg"),
	preload("res://assets/screen/video/annie-spratt-wgivdx9dBdQ-unsplash.jpg"),
	preload("res://assets/screen/video/nastuh-abootalebi-JdcJn85xD2k-unsplash.jpg"),
]
var unlock_codes = [
	"1234",
	"0032",
	"2004",
	"2001",
]

func reset() -> void:
	game_started = false
	camera2_unlocked = false
	camera3_unlocked = false
	unlocked_doors = [false, false]
	ending_choice = 0
