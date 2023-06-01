extends MeshInstance3D
class_name Jeton

#gestion de la vitesse des jetons et de leur accélération à faire !

var y_final: int
var vitesse:float

func _init(column:int,y_start:int,_y_final):
	transform.origin=Vector3(0,y_start,column)
	self.y_final=_y_final
	self.vitesse=Global.JETON.VITESSE_INITIALE
	pass

func _process(delta):
	self.vitesse+=delta*Global.JETON.ACCELERATION
	transform.origin.y += vitesse*delta
	# Vérifie si le pion a atteint la dernière rangée (y_final)
	if transform.origin.y <= y_final:
		transform.origin.y = y_final
		set_process(false)#la fonction _process ne sera plus appelé
