extends Sprite3D

var descentSpeed = 1.0
var raycast: RayCast3D

func _ready():
	raycast = $RayCast

func _process(delta):
	print("Hello")
	move_down(delta)

func move_down(delta):
	var motion = Vector3(0, -descentSpeed * delta, 0)

	raycast.cast_to = motion
	raycast.force_raycast_update()

	if raycast.is_colliding():
		var collider = raycast.get_collider()

		if collider is MeshInstance3D:
			# Collision avec un autre MeshInstance3D en dessous, arrêter la descente
			descentSpeed = 0.0
		else:
			descentSpeed = 1.0

	global_transform.origin += motion
