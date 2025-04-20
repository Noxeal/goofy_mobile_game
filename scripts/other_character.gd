extends CharacterBody3D

@export var target: Node3D
@export var follow_distance: float = 2
@export var speed: float = 20
@export var gravity: float = 500

func _physics_process(delta):
	if not (is_on_floor()):
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
		
	if target:
		var direction = (target.global_transform.origin - global_transform.origin)
		var distance = direction.length()

		if distance > follow_distance:
			direction = direction.normalized()
			velocity = direction * speed
			move_and_slide()
		else:
			velocity = Vector3.ZERO
