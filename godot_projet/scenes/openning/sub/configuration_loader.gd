extends "res://autoload/global_fonction.gd"

onready var premier = get_node("Premiere")


func _ready():
	
	ouverture()
	
	premier.visible = false

	#controle du dossier de support...
	if test_support_folder() == false:
		Global_Variable.build_phase = "Première ouverture . . ."
		premier.visible = true
		attent(1)
		yield($Premiere/Button, "pressed")
		build_support_folder()
		premier.visible = false
		
	else:
		#Chargement des fichiers de configuration
		config_licence_load()
		config_user_load()
		config_environnement_load()
		
		build_theme()
		


















# teste du dossier de support...
func test_support_folder() -> bool:
	var dir = Directory.new()
	if dir.dir_exists(simpleCAD_data_dir) == false:
		print("Dossier ", name_version, " non trouvé...")
		return false
	else:
		print("Dossier ", name_version, " trouvé...")
		return true

func build_support_folder():
	#OS.alert(message["first_opening_titre"], message["first_opening_message"])
	var dir = Directory.new()
	dir.open(user_data_dir)
	dir.make_dir(name_version)
	print("Dossier "+ name_version +" créer avec succés...")





















# Chargement du fichier de licence...
func config_licence_load():
	var config = ConfigFile.new()
	var array = OS.get_unique_id().sha256_buffer()
	var lic_cfg = config.load_encrypted(cfg_lic_path, PoolByteArray(array))
	if lic_cfg != OK :
		config_licence_create()
	else :
		config_licence_attribut()

func config_licence_create():
	var array = OS.get_unique_id().sha256_buffer()
	var config = ConfigFile.new()
	config.set_value("data", "UID", OS.get_unique_id())
	config.set_value("data", "nombre_ouverture", 0)
	config.save_encrypted(cfg_lic_path, PoolByteArray(array))
	config.clear()
	print("Fichier créer avec succès = ", cfg_lic_name)

func config_licence_attribut():
	var array = OS.get_unique_id().sha256_buffer()
	var config = ConfigFile.new()
	config.load_encrypted(cfg_lic_path, PoolByteArray(array))
	for data in config.get_sections():
			Global_Variable.nombre_ouverture = config.get_value(data, "nombre_ouverture")
			Global_Variable.licence_key = config.get_value(data, "licence_key")
	print("Variables de licence attribuées avec succès... ")
















# Chargement du fichier de l'environnement...
func config_environnement_load():
	var config = ConfigFile.new()
	var env_cfg = config.load(cfg_env_path)
	if env_cfg != OK: 
		config_environnement_create()
	else: 
		config_environnement_attribut()

func config_environnement_create():
	var config = ConfigFile.new()
	config.set_value("data", "last_user", "User0")
	config.set_value("data", "bibliotheque_path", "")
	config.save(cfg_env_path)
	print("Fichier créer avec succès = ", cfg_env_name)

func config_environnement_attribut():
	var config = ConfigFile.new()
	config.load(cfg_env_path)
	for data in config.get_sections():
			Global_Variable.last_user = config.get_value(data, "last_user")
	print("Variables d'environnement attribuées avec succès...")










# Chargement du fichier des utilisateurs...
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







func ouverture():
#	yield(get_tree().create_timer(1), "timeout")
#	Global_Variable.build_phase = "Ouverture"
#	yield(get_tree().create_timer(0.75), "timeout")
#	Global_Variable.build_phase = "Ouverture ."
#	yield(get_tree().create_timer(0.75), "timeout")
#	Global_Variable.build_phase = "Ouverture . ."
#	yield(get_tree().create_timer(0.75), "timeout")
	Global_Variable.build_phase = "Ouvertur❢e . . ."
	yield(get_tree().create_timer(1), "timeout")
	
	Global_Variable.build_phase = "Lecture des fichiers de configurations . . ."
	yield(get_tree().create_timer(1), "timeout")
	
	var node_openning = get_node("/root/Openning")
	node_openning.build_process("licence")










