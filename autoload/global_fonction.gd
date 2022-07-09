extends "res://autoload/global_variable.gd"

func global_variable_printer():
	print("--- global variable printer ---")
	print("Localisation : ", locale)
	print("Plateforme : ", model_name)
	print("UID de la machine : ", machine_id)
	print("--- --- ---")









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



























### CONFIG LICENCE FILE ###

func load_encrypt_file():
	var config = ConfigFile.new()
	var array = OS.get_unique_id().sha256_buffer()
	var err = config.load_encrypted(cfg_lic_path, PoolByteArray(array))
	if err != OK :
		config.set_value("data", "UID", OS.get_unique_id())
		config.set_value("data", "nombre_ouverture", 5)
		config.save_encrypted(cfg_lic_path, PoolByteArray(array))
		config.clear()
		print("Fichier créer avec succès = ", cfg_lic_name)
	else :
		for data in config.get_sections():
			var UID = config.get_value(data, "UID")
			var nombre_ouverture = config.get_value(data, "nombre_ouverture")
			nombre_ouverture = nombre_ouverture-1
			if nombre_ouverture <= 0:
				nombre_ouverture = 0
			print("Nombre ouverture restante = ", nombre_ouverture)
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







func build_SimpleCAD():
	#Controle de la licence
	if nombre_ouverture == 0:
		OS.alert(message["more_opening_message"], message["more_opening_titre"])
		get_tree().quit()
		
	#Controle de la version
		#mise à jour ou non
	#Construction de l'environnement de travail :
		#Construction du fichier de theme
		#Construction du fichier de raccourcis clavier
		#Analyse des dossiers de la bibliothèque…
		#Construction de la bibliothèque
	pass

















### Fonctions lié à la fenetre

func set_win_load():
	OS.window_borderless = true
	OS.window_resizable = false
	OS.set_window_per_pixel_transparency_enabled(true)
	get_tree().get_root().set_transparent_background(true)
	OS.window_size = Vector2(600, 400)
	OS.center_window()
	pass


func set_win_normale():
	OS.window_borderless = false
	OS.window_resizable = true
	OS.set_window_per_pixel_transparency_enabled(false)
	get_tree().get_root().set_transparent_background(false)
	OS.window_size = Vector2(1200, 800)
	OS.center_window()
	OS.set_window_title(str(name_version+" - "+current_space))
	pass



