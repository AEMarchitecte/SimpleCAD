extends "res://autoload/global_fonction.gd"


func _ready():
	set_win_load()
	testpersistantfolder()
	
	load_config_files()
	
	build_theme()
	build_bibliotheque()
	build_SimpleCAD()
	pass

func load_config_files():
	load_encrypt_file()
	config_user_load()
	config_environnement_load()

func build_theme():
	var theme = load("res://graphique/theme/SimpleCAD.theme")
	var panel = load("res://graphique/theme/Panel_base.stylebox")
	var color_p1 = Global_Variable.user_theme["color_p1"]
	var color_p2 = Global_Variable.user_theme["color_p2"]
	var color_user = Global_Variable.user_theme["color_user"]
	
	theme.set_color("font_color", "Label", color_p1)
	panel.set_bg_color(color_p2)

func build_shrotcut():
	pass







func build_bibliotheque():
	
	print(str(bibliotheque_path))
	print(bibliotheque_path)
	
	
	
	
	
	
	
	
	
	
	
	
func build_SimpleCAD():
	
	yield(get_tree().create_timer(2), "timeout")
	Global_Variable.build_message = "Ouverture..."
	
	
	
	#Controle de la licence
	yield(get_tree().create_timer(1), "timeout")
	Global_Variable.build_message = "Contrôle de la licence..."
	yield(get_tree().create_timer(1), "timeout")
	nombre_ouverture = Global_Variable.nombre_ouverture
	#print("Nombre ouverture restante = ", nombre_ouverture)
	if nombre_ouverture <= 0:
		
		pass
	
	
	
	
	#Controle de la version
	yield(get_tree().create_timer(2), "timeout")
	Global_Variable.build_message = "Recherche de mises à jours..."
	yield(get_tree().create_timer(5), "timeout")
		#mise à jour ou non
		
	
	
	yield(get_tree().create_timer(5), "timeout")
	Global_Variable.build_message = "Construction de l'environnement de travail"
	#Construction de l'environnement de travail :
		#Construction du fichier de theme
		#Construction du fichier de raccourcis clavier
		#Analyse des dossiers de la bibliothèque…
		#Construction de la bibliothèque
		
		
		
	
	yield(get_tree().create_timer(2), "timeout")
	Global_Variable.build_message = "Lancement !"
	yield(get_tree().create_timer(1), "timeout")
	
	get_tree().change_scene("res://scenes/02_lanceur/lanceur.tscn")
