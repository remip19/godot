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
@onready var label = $"../Label"
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
	jeton_values[column*size.y+hauteur] = player_value
	var j=Jeton.new(column,size.y, hauteur)
	add_child(j)
	j.mesh= mesh_token
	j.set_surface_override_material(0,player_material[player_value-1])
	var win = check_win()
	label.text = str({"v" : check_vertical_win(column,hauteur), "h":check_Horizontal_win(column,hauteur), "\\":check_diagonal_descendante(column,hauteur), "/": check_diagonal_montante(column,hauteur)})
	if win>0: print("win: ", win) 
	elif win<0: print("égalité") 
	else : print ("Rien")
	
	return true

func set_player_material():
	var m1:ShaderMaterial=material_token
	var m2:ShaderMaterial=material_token.duplicate()
	var v = int(m1.get_shader_parameter("tokenId"))^3
	m2.set_shader_parameter("tokenId",v)
	player_material.append(m1)
	player_material.append(m2)
	pass
	
var player = 1
	
func DBG_play():
	var column = randi()%size.x
	if ajouter_jeton(column,player):
		player^=3
		#player^=0



func check_win():
	var b = false
	#print("----------------------")
	for c in range(size.x):
		for h in range(size.y):
			var index = size.y*c+h
			if jeton_values[index] >0: 
				b = int(check_vertical_win(c,h)) + int(check_Horizontal_win(c,h))*2 + int(check_diagonal_descendante(c,h))*4 + int(check_diagonal_montante(c,h))*8
				
				#print([c,h])
				#print({"v" : check_vertical_win(c,h), "h":check_Horizontal_win(c,h), "\\":check_diagonal_descendante(c,h), "/": check_diagonal_montante(c,h)})
				if b :
					print(b) 
					return jeton_values[index]
					
	return -1 if check_par() else 0
	
func check_par():
	for i in range(size.y-1, size.y*size.x, size.y):
		if jeton_values[i] == 0:
			return false
	return true
	
func check_vertical_win(column, hauteur):
	var index = size.y*column+hauteur
	var value = jeton_values[index]
	var compteur = 1
	var i = index
	var h = hauteur
	#on verifie si il y a des pion en dessous
	while compteur < 4 && h > 0 && jeton_values[i-1] == value:
		compteur +=1
		h -= 1 
		i -= 1
		#if compteur > 4
		
	return compteur==4

func check_Horizontal_win(column, hauteur):

	var index = size.y*column+hauteur
	var value = jeton_values[index]
	var compteur = 0
	var i = index
	var max = size.x*size.y
	
	while compteur <4 && i < max && jeton_values[i] == value:
		compteur +=1
		i += size.y
	return compteur ==4
	
func check_diagonal_descendante(column, hauteur):
	var h = hauteur
	var index = size.y*column+hauteur
	var value = jeton_values[index]
	var compteur = 0
	var i = index
	var max = size.x*size.y
	while compteur <4 && i < max &&  h > 0 && jeton_values[i] == value:
		compteur +=1
		i += size.y -1
		h -= 1 
	return compteur ==4
	
func check_diagonal_montante(column, hauteur):
	var h = hauteur
	var index = size.y*column+hauteur
	var value = jeton_values[index]
	var compteur = 0
	var i = index
	var max = size.x*size.y
	while compteur <4 && i < max &&  h < size.y && jeton_values[i] == value:
		compteur +=1
		i += size.y +1
		h += 1 
	return compteur == 4


func _on_button_2_pressed():
	rebuild()
	pass # Replace with function body.
