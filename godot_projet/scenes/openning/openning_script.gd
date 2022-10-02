extends "res://autoload/global_fonction.gd"

onready var process_box = get_node("Panel/BoxMessage")

func _ready():
	#test_integrity()
	
	set_win_load()
	
	build_process("configuration_loader")

func build_process(valeur):
	
	#print("build_process = ", valeur)
	
	#Chargement des configurations
	if valeur == "configuration_loader":
		print("--- configuration ---")
		delete_childrens(process_box)
		load_scene_at("res://scenes/openning/sub/configuration_loader.tscn", process_box)
		
	#Controle de la licence
	if valeur == "licence":
		print("--- licence ---")
		delete_childrens(process_box)
		load_scene_at("res://scenes/openning/sub/Licence_controler.tscn", process_box)
		
	#Controle de la version
	if valeur == "update_app":
		print("--- update ---")
		delete_childrens(process_box)
		load_scene_at("res://scenes/openning/sub/update_app.tscn", process_box)
	
	#Construction de l'environnement
	if valeur == "environnement":
		print("--- environnement ---")
		delete_childrens(process_box)
		load_scene_at("res://scenes/openning/sub/environnement_loader.tscn", process_box)
	
	#Affichage du lanceur...
	if valeur == "open_launcher":
		Global_Variable.build_phase = "Lancement . . ."
		yield(get_tree().create_timer(1), "timeout")
		#get_tree().change_scene("res://scenes/App.tscn")
		get_tree().change_scene("res://scenes/Global_Application.tscn")
		
		#var base = get_node("/root/")
		#load_scene_at("res://scenes/App.tscn", base)











































































