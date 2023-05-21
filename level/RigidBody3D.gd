extends RigidBody3D

var movementSpeed = 5.0

func _physics_process(delta):
	var motion = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		motion.z -= 1.0
	if Input.is_action_pressed("move_backward"):
		motion.z += 1.0
	if Input.is_action_pressed("move_left"):
		motion.x -= 1.0
	if Input.is_action_pressed("move_right"):
		motion.x += 1.0

	motion = motion.normalized() * movementSpeed

	# Appliquer le mouvement au RigidBody
	linear_velocity = motion
