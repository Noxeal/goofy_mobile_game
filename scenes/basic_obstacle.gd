extends Area3D

signal player_hit(player: CharacterBody3D)

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D and body.name != "MainCharacter":
		#print(body, "a touché l'obstacle")
		emit_signal("player_hit", body)
