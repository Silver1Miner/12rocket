extends Spatial

func _ready() -> void:
	$Props/Mannequin2.visible = false
	Music.play_music("ambient")

func _on_Exit_body_entered(body: Node) -> void:
	if body.is_in_group("player") and PlayerData.game_started:
		body.end_game()

func _on_StartTrigger_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		PlayerData.game_started = true

func _on_SignTrigger_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		randomize()
		if rand_range(1,10) > 8:
			$Signs/OfficePoster.visible = false
			$Signs/OfficePoster2.visible = true
		else:
			$Signs/OfficePoster.visible = true
			$Signs/OfficePoster2.visible = false


func _on_MannequinTrigger_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		$Props/Mannequin2.visible = true
