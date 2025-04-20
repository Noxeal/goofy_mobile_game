extends Button

signal restart_button_pressed()

func _on_button_down() -> void:
	emit_signal("restart_button_pressed")
