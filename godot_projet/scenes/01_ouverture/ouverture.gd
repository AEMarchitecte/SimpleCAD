extends "res://autoload/global_fonction.gd"


func _ready():
	set_win_load()
	testpersistantfolder()
	
	load_config_files()
	
	build_theme()
	build_bibliotheque()
	build_SimpleCAD()
	pass










func testpersistantfolder():
	var dir = Directory.new()
	if dir.dir_exists(simpleCAD_data_dir) == false:
		print("Dossier ", name_version, " non trouvé...")
		makepersistantfolder()
	else:
		print("Dossier ", name_version, " trouvé...")

func makepersistantfolder():
	OS.alert(message["first_opening_titre"], message["first_opening_message"])
	var dir = Directory.new()
	dir.open(user_data_dir)
	dir.make_dir(name_version)
	print("Dossier "+ name_version +" créer avec succés...")






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
	
	
	
	
	
	
	


### CONFIG LICENCE FILE ###

func load_encrypt_file():
	var config = ConfigFile.new()
	var array = OS.get_unique_id().sha256_buffer()
	var err = config.load_encrypted(cfg_lic_path, PoolByteArray(array))
	if err != OK :
		config.set_value("data", "UID", OS.get_unique_id())
		config.set_value("data", "nombre_ouverture", 25)
		config.save_encrypted(cfg_lic_path, PoolByteArray(array))
		config.clear()
		print("Fichier créer avec succès = ", cfg_lic_name)
	else :
		for data in config.get_sections():
			var UID = config.get_value(data, "UID")
			var nombre_ouverture = config.get_value(data, "nombre_ouverture")
			print("Variables de licence attribuées avec succès...")
			nombre_ouverture = nombre_ouverture-1
			print("Nombre ouverture restante = ", nombre_ouverture)
			if nombre_ouverture <= 0:
				OS.alert(message["more_opening_message"], message["more_opening_titre"])
				get_tree().quit()
				#nombre_ouverture = 0
			config.set_value("data", "nombre_ouverture", nombre_ouverture)
			config.save_encrypted(cfg_lic_path, PoolByteArray(array))



### CONFIG ENVIRONNEMENT FILE ###

func config_environnement_load():
	var config = ConfigFile.new()
	var env_cfg = config.load(cfg_env_path)
	if env_cfg != OK: 
		config_environnement_create()
	else: 
		config_environnement_attribut()

func config_environnement_create():
	var config = ConfigFile.new()
	config.set_value("data", "last_user", "Baptiste")
	config.set_value("data", "WWW", 111)
	config.save(cfg_env_path)
	print("Fichier créer avec succès = ", cfg_env_name)
	
func config_environnement_attribut():
	var config = ConfigFile.new()
	config.load(cfg_env_path)
	for data in config.get_sections():
			var last_user = config.get_value(data, "last_user")
	print("Variables d'environnement attribuées avec succès...")


### CONFIG USERS FILE ###

func config_user_load():
	var config = ConfigFile.new()
	var use_cfg = config.load(cfg_use_path)
	if use_cfg != OK:
		config_user_create()
	else: 
		config_user_attribut()
		

func config_user_create():
	var config = ConfigFile.new()
	config.set_value("user0", "identity", defaut_user_identity)
	config.set_value("user0", "shortcut", defaut_user_shortcuts)
	config.set_value("user0", "theme", defaut_user_theme)
	config.set_value("user0", "settings", defaut_user_settings)
	config.save(cfg_use_path)
	print("Fichier créer avec succès = ", cfg_use_name)

func config_user_attribut():
	var config = ConfigFile.new()
	config.load(cfg_use_path)
	for data in config.get_sections():
			last_user = config.get_value(data, "last_user")
	print("Variables de l'utilisateur attribuées avec succès...")



