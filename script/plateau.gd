@tool 

extends Node3D
class_name Plateau


@export var size: Vector2i = Vector2i(7, 6): 
	get:return size
	set(value):
		var old = size
		size=value
		if old != size :
			_on_cosmetic_change("size",old,size)
@export_category("Cosmetic")
@export_group("plateau")
@export var mesh_case: Mesh
@export var material_case: Material
@export_group("jeton")
@export var mesh_token: Mesh
@export var material_token: ShaderMaterial
var player_material:Array[ShaderMaterial]
var jeton_values: Array[int]


func reset_jeton_values():
	jeton_values.clear()
	jeton_values.resize(size.x*size.y)
	jeton_values.fill(0)
	pass

func _add_case(x: int, y: int):
	var mi3D: MeshInstance3D = MeshInstance3D.new()
	mi3D.material_override = material_case
	mi3D.mesh = mesh_case
	mi3D.transform.origin = Vector3(0, y, x)
	add_child(mi3D)

func _ready():
	rebuild()
	set_player_material()
	ajouter_jeton(1,1)
	#await(get_tree().create_timer(1.0))
	ajouter_jeton(2,2)
	ajouter_jeton(3,1)
	ajouter_jeton(3,2)#erreur superposition
	#ajouter_jeton(3,1)
	#ajouter_jeton(2,1)
	
func _process(_delta):
	pass


func _physics_process(_delta):
	pass

var nb_column: int:
	get:return size.x

var nb_row: int:
	get:return size.y

func rebuild():
	reset_jeton_values()
	for child in get_children():
		remove_child(child)
	for x in range(nb_column):
		for y in range(nb_row):
			_add_case(x, y)

func _on_cosmetic_change(attr_name, old, new):
	print("change ",{"name":attr_name,"old value":old,"new value":new})
	rebuild()

func final_height(c:int)->int:
	var i: int =0
	while i<size.y and jeton_values[c*size.y+i]!=0:
		i+=1
	return i
	
func ajouter_jeton(column:int, player_value:int)->bool:
	if column >= size.x: return false
	var hauteur: int = final_height(column)
	if hauteur >= size.y: return false
	var j=Jeton.new(column,size.y, hauteur)
	add_child(j)
	j.mesh= mesh_token
	j.set_surface_override_material(0,player_material[player_value-1])
	return false

func set_player_material():
	var m1:ShaderMaterial=material_token
	var m2:ShaderMaterial=material_token.duplicate()
	var v = int(m1.get_shader_parameter("tokenId"))^3
	m2.set_shader_parameter("tokenId",v)
	player_material.append(m1)
	player_material.append(m2)
	pass
