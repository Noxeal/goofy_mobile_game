extends Node3D

@onready var player_amount = 0
@onready var other_player = preload("res://scenes/other_character.tscn")
@onready var main_player = get_node("MainCharacter")
@onready var label_amount = $Label_Amount
 
var player_clones: Array = []

func _ready() -> void:
	connect_all_portes(self)
	connect_all_obstacles(self)
	
	add_new_player(Vector3(main_player.position.x, main_player.position.y, main_player.position.z+1))

func connect_all_portes(node):
	for child in node.get_children():
		if child.has_signal("player_entered"):
			child.connect("player_entered", Callable(self, "_on_porte_entered"))
			print("Connecté à :", child.name)
		elif child.get_child_count() > 0:
			connect_all_portes(child)

func connect_all_obstacles(node):
	for child in node.get_children():
		if child.has_signal("player_hit"):
			child.connect("player_hit", Callable(self, "_on_obstacle_hit"))
			print("Connecté à :", child.name)
		elif child.get_child_count() > 0:
			connect_all_obstacles(child)
			
func _on_obstacle_hit(child):
	if player_clones.has(child):
		player_clones.erase(child)
		child.queue_free()
		player_amount -= 1
		label_amount.text = "Amount :" + str(player_amount)

func add_new_player(pos: Vector3):
	var new_player = other_player.instantiate()
	new_player.position = Vector3(pos.x, pos.y, pos.z)
	new_player.target = main_player
	
	add_child(new_player)
	
	player_amount += 1
	player_clones.append(new_player)
	label_amount.text = "Amount :" + str(player_amount)
	
func _on_porte_entered(operator: String, multiplier: int) -> void:
	print("Porte traversée avec :", operator, multiplier)
	
	if operator == "+":
		for i in range(1, multiplier+1):			
			if i%2 == 0:
				add_new_player(Vector3(main_player.position.x+1, main_player.position.y, main_player.position.z+(i/2)))
			else:
				add_new_player(Vector3(main_player.position.x-1, main_player.position.y, main_player.position.z+(i/2)))
		
	elif operator == "x":
		
		var added_amount = player_amount * multiplier - player_amount
		for i in range(1, added_amount+1):
			if i%2 == 0:
				add_new_player(Vector3(main_player.position.x+1, main_player.position.y, main_player.position.z+(i/2)))
			else:
				add_new_player(Vector3(main_player.position.x-1, main_player.position.y, main_player.position.z+(i/2)))
				
		
	elif operator == "-":
		for i in range(multiplier):
			if player_clones.size() > 1:
				var player_to_delete = player_clones.pop_back()
				player_to_delete.queue_free()
				player_amount -= 1
	
	print("Nombre de bonhommes : ", player_amount)
	label_amount.text = "Amount :" + str(player_amount)
