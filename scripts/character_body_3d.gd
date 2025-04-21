extends CharacterBody3D

@export var speed: float = 10
@export var lateral_speed: float = 0.5
@export var gravity: float = 50
@export var game_running = true

func _physics_process(delta):
	if (not is_on_floor()) and game_running:
		velocity.y -= gravity * delta
		# Mouvement du joueur vers l'avant
		velocity.z = -speed
	else:
		velocity.y = 0
		
	# Déplacement latéral 
	if Input.is_action_pressed("ui_right") and game_running:
		velocity.x += lateral_speed
	if Input.is_action_pressed("ui_left") and game_running:
		velocity.x -= lateral_speed

	
	move_and_slide()
