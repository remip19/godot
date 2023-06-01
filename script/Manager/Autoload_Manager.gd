extends Node
class_name Autoload_Manager
enum GameState {MAIN_MENU,OPTION,GAME}

var state:GameState
var 
# Called when the node enters the scene tree for the first time.
func _ready():
	state=GameState.MAIN_MENU
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
