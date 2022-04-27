extends Spatial

var spawn_points := [
	Vector3(14,8,-14),
	Vector3(14,1,0),
	Vector3(14,1,-14),
	Vector3(-8,1,0),
	Vector3(14,8,0),
	Vector3(-8,1,-14),
]

export (PackedScene) var zombie = preload("res://src/characters/Zombie.tscn")

var spawn_pace := [200, 150, 150, 100, 80, 60]

var spawn_accumulated = 0
var timer_accumulated = 0
var spawn_level = 0
func _process(_delta: float) -> void:
	spawn_accumulated += 1
	timer_accumulated += 1
	if spawn_accumulated > spawn_pace[spawn_level]:
		spawner()
	if timer_accumulated > 600:
		if spawn_level < len(spawn_pace) - 1:
			spawn_level += 1
		timer_accumulated = 0
		print("spawn level increased to ", spawn_level)

func spawner() -> void:
	if get_child_count() >= 10:
		#print("enemy limit reached")
		return
	else:
		randomize()
		var spawn_index = round(rand_range(0,5))
		var spawn_point = spawn_points[spawn_index]
		spawn_enemy(spawn_point)
		spawn_accumulated = 0

func spawn_enemy(spawn_position: Vector3) -> void:
	var enemy = zombie.instance()
	add_child(enemy)
	enemy.global_transform.origin = spawn_position

