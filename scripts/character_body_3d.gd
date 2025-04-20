extends CharacterBody3D

@export var speed: float = 10
@export var lateral_speed: float = 0.5
@export var gravity: float = 50

func _physics_process(delta):
	if not (is_on_floor()):
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
		
	# Déplacement latéral 
	if Input.is_action_pressed("ui_right"):
		velocity.x += lateral_speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= lateral_speed
	# Mouvement du joueur vers l'avant
	velocity.z = -speed
	
	move_and_slide()
