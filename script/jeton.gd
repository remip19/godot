extends MeshInstance3D
class_name Jeton

#gestion de la vitesse des jetons et de leur accélération à faire !

var y_final: int

func _init(column:int,y_start:int,_y_final):
	transform.origin=Vector3(0,y_start,column)
	self.y_final=_y_final
	pass

func _process(delta):
	transform.origin.y += delta*Global.JETON.VITESSE_INITIALE
	
	# Vérifie si le pion a atteint la dernière rangée (y_final)
	if transform.origin.y <= y_final:
		set_process(false)#la fonction _process ne sera plus appelé
		transform.origin.y = y_final

#v=v+a*delta
#p=p+v*delta     p= position   graviter négative pour dessendre = a    a =-10     v=-2
