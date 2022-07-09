extends "res://autoload/global_fonction.gd"



func _ready():
	set_win_load()
	testpersistantfolder()
	load_encrypt_file()
	config_user_load()
	config_environnement_load()
	
	#build_SimpleCAD()
#	yield(get_tree().create_timer(2), "timeout")
#	set_win_normale()
	pass
