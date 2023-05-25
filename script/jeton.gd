extends MeshInstance3D
class_name Jeton

var y_final: int


func _init(column:int,y_start:int,_y_final):
	transform.origin=Vector3(0,y_start,column)
	self.y_final=_y_final
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

