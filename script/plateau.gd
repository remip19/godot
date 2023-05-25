@tool 

extends Node3D
class_name Plateau

@export var size: Vector2i = Vector2i(7, 6)
@export_category("Cosmetic")
@export_group("plateau")
@export var mesh_case: Mesh
@export var material_case: Material
@export_group("jeton")
@export var mesh_token: Mesh
@export var material_token: ShaderMaterial

func _add_case(x: int, y: int):
	var mi3D: MeshInstance3D = MeshInstance3D.new()
	mi3D.material_override = material_case
	mi3D.mesh = mesh_case
	mi3D.transform.origin = Vector3(0, y, x)
	add_child(mi3D)

func _ready():
	print("salut")
	rebuild()


func _process(_delta):
	pass


func _physics_process(_delta):
	pass


var nb_column: int:
	get:return size.x

var nb_row: int:
	get:return size.y


func rebuild():
	for child in get_children():
		remove_child(child)
	for x in range(nb_column):
		for y in range(nb_row):
			_add_case(x, y)
	print(get_children())


