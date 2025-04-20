extends Area3D

const possible_operators = ['x', '-', '+']
@onready var audio_good = $AudioSuper
@onready var audio_bad = $AudioPasSuper
@onready var label = $SubViewport/Label

@onready var chosen_operator: String
@onready var multiplier = randi_range(1, 20)

signal player_entered(operator: String, multiplier: int)

func _ready() -> void:
	chosen_operator = possible_operators[randi_range(0, possible_operators.size() - 1)]
	print(chosen_operator + str(multiplier))
	label.text = chosen_operator + str(multiplier)
	
func _on_body_entered(body: Node3D) -> void:
	if body.name == "MainCharacter":
		if chosen_operator == "-":
			audio_bad.play()
		else:
			audio_good.play()
		emit_signal("player_entered", chosen_operator, multiplier)
