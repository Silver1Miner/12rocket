extends Node

var world = preload("res://src/world/World.tscn")
var main_menu = preload("res://src/menu/MainMenu.tscn")
var music_db = 0.2
var sound_db = 0.1

var camera2_unlocked := false
var camera3_unlocked := false
var unlocked_doors = [false, false]

var camera_feed = [
	preload("res://assets/screen/video/annie-spratt-wgivdx9dBdQ-unsplash.jpg"),
	preload("res://assets/screen/video/nastuh-abootalebi-JdcJn85xD2k-unsplash.jpg"),
	preload("res://assets/screen/video/nastuh-abootalebi-rSpMla5RItA-unsplash.jpg")
]
var unlock_codes = [
	"1234",
	"0032",
	"2004",
	"2001",
]
