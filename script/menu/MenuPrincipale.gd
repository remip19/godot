extends Control
class_name MenuPrincipale

signal on_button_pressed(action:ButtonMenuAction)


enum ButtonMenuAction {NONE,PLAY,OPTION,QUIT}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func resignal_button(value:int):
	emit_signal("on_button_pressed",value)
