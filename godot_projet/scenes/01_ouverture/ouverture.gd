extends "res://autoload/global_fonction.gd"

onready var box_premiere = get_node("Panel/BoxMessage/Premiere")
onready var box_licence = get_node("Panel/BoxMessage/Licence")


func _ready():
	set_win_load()
	build_process()


func build_process():
	
	build_theme()
	ouverture()
	yield(get_tree().create_timer(2.5), "timeout")
	
	#controle du dossier de support...
	if test_support_folder() == false:
		box_premiere.visible = true
		Global_Variable.build_phase = "Première ouverture . . ."
		yield($Panel/BoxMessage/Premiere/Button, "pressed")
		box_premiere.visible = false
		build_support_folder()
	
	#Chargement des fichiers de configuration
	config_licence_load()
	config_user_load()
	config_environnement_load()
	#Construction du theme
	build_theme()
	yield(get_tree().create_timer(2), "timeout")
	
	
	#Controle de la licence
	Global_Variable.build_phase = "Contrôle de la licence . . ."
	yield(get_tree().create_timer(1), "timeout")
	
	
	
	
	
	if key_is_valide() == true:
		Global_Variable.build_phase = "Clef de licence valide !"
		yield(get_tree().create_timer(2), "timeout")
	else:
		if licence_controler() == false:
			box_licence.visible = true
			yield($Panel/BoxMessage/Licence/HBoxContainer/Button, "pressed")
			var key_enter = $Panel/BoxMessage/Licence/HBoxContainer/key.text
			licence_key_save(key_enter)

			# Porte de sortie...
			box_licence.visible = false
			Global_Variable.build_phase = "Clef de licence non valide !"
			fermeture()
			yield(get_tree().create_timer(10), "timeout")
	
	
	
	
	
	#Controle de la version
	Global_Variable.build_phase = "Recherche de mises à jours . . ."
	yield(get_tree().create_timer(2), "timeout")
	version_controler()
	
	
	###
	
	
	#Construction de l'environnement de travail :
	Global_Variable.build_phase = "Construction de l'environnement de travail . . ."
	yield(get_tree().create_timer(2), "timeout")
	#Construction du fichier de raccourcis clavier
	#Analyse des dossiers de la bibliothèque…
	
	#Construction des ressources de la bibliotheque
	# func 
	build_bibliotheque()
	
	
	
	#Affichage du lanceur...
	Global_Variable.build_phase = "Lancement !"
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://scenes/02_lanceur/lanceur.tscn")


























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









func licence_controler() -> bool:
	print("Nombre d'ouverture avant = ", Global_Variable.nombre_ouverture)
	var nb = Global_Variable.nombre_ouverture+1
	
	var array = OS.get_unique_id().sha256_buffer()
	var config = ConfigFile.new()
	config.load_encrypted(cfg_lic_path, PoolByteArray(array))
	config.set_value("data", "nombre_ouverture", nb)
	config.save_encrypted(cfg_lic_path, PoolByteArray(array))
	print("Actualisation du nombre d'ouverture...")
	print("Nombre d'ouverture après = ", nb)
	
	if nb > 5:
		return false
	else:
		return true

func licence_key_save(key_enter):
	var array = OS.get_unique_id().sha256_buffer()
	var config = ConfigFile.new()
	config.load_encrypted(cfg_lic_path, PoolByteArray(array))
	config.set_value("data", "licence_key", key_enter)
	config.save_encrypted(cfg_lic_path, PoolByteArray(array))
	print("Enregistrement de la licence_key = ", key_enter)

func key_is_valide() -> bool:
	var key_register = Global_Variable.licence_key
	var key_true = OS.get_unique_id().sha256_text()
	#print("key_register = ", key_register)
	print("key_true = ", key_true)
	if key_register == key_true:
		return true
	else:
		return false






func version_controler():
	pass

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


func ouverture():
	Global_Variable.build_phase = "Ouverture"
	yield(get_tree().create_timer(0.75), "timeout")
	Global_Variable.build_phase = "Ouverture ."
	yield(get_tree().create_timer(0.75), "timeout")
	Global_Variable.build_phase = "Ouverture . ."
	yield(get_tree().create_timer(0.75), "timeout")
	Global_Variable.build_phase = "Ouvertur❢e . . ."
	yield(get_tree().create_timer(0.75), "timeout")

func fermeture():
	yield(get_tree().create_timer(2), "timeout")
	Global_Variable.build_phase = "Fermeture"
	yield(get_tree().create_timer(0.75), "timeout")
	Global_Variable.build_phase = "Fermeture ."
	yield(get_tree().create_timer(0.75), "timeout")
	Global_Variable.build_phase = "Fermeture . ."
	yield(get_tree().create_timer(0.75), "timeout")
	Global_Variable.build_phase = "Fermeture . . ."
	yield(get_tree().create_timer(0.75), "timeout")
	get_tree().quit()
	

