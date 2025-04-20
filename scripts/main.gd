extends Node3D

@onready var player_amount = 1
@onready var other_player = preload("res://scenes/other_character.tscn")
@onready var main_player = get_node("MainCharacter")

var player_clones: Array = []

func _ready() -> void:
	connect_all_portes(self)

func connect_all_portes(node):
	for child in node.get_children():
		if child.has_signal("player_entered"):
			child.connect("player_entered", Callable(self, "_on_porte_entered"))
			print("Connecté à :", child.name)
		elif child.get_child_count() > 0:
			connect_all_portes(child)

func _on_porte_entered(operator: String, multiplier: int) -> void:
	print("Porte traversée avec :", operator, multiplier)
	
	if operator == "+":
		for i in range(1, multiplier):
			var new_player = other_player.instantiate()
			if i%2 == 0:
				new_player.position = Vector3(main_player.position.x+(i*1), main_player.position.y+(i*1), main_player.position.z+(i*1))
			else:
				new_player.position = Vector3(main_player.position.x-(i*1), main_player.position.y+(i*1), main_player.position.z+(i*1))
				
			new_player.target = main_player
			add_child(new_player)
			
			player_clones.append(new_player)

		player_amount += multiplier
		print("+")
		
	elif operator == "x":
		
		var added_amount = player_amount * multiplier - player_amount
		for i in range(1, added_amount):
			var new_player = other_player.instantiate()
			if i%2 == 0:
				new_player.position = Vector3(main_player.position.x+(1), main_player.position.y+(i/2), main_player.position.z+(i/2))
			else:
				new_player.position = Vector3(main_player.position.x-(1), main_player.position.y+(i/2), main_player.position.z+(i/2))
				
			new_player.target = main_player
			add_child(new_player)
			
			player_clones.append(new_player)


		player_amount += added_amount
		print("x")
		
	elif operator == "-":
		for i in range(multiplier):
			if player_clones.size() > 0:
				var player_to_delete = player_clones.pop_back()
				player_to_delete.queue_free()
				player_amount -= 1
		print("-")
