extends "res://autoload/global_fonction.gd"



func _ready():
	Global_Variable.build_phase = "Construction de l'environnement . . ."
	yield(get_tree().create_timer(1), "timeout")
	
	var node_openning = get_node("/root/Openning")
	node_openning.build_process("open_launcher")










func build_shrotcut():
	pass


