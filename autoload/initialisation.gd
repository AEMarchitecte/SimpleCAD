extends Node

onready var user_data_dir = OS.get_user_data_dir()
onready var simpleCAD_data_dir = user_data_dir+"/"+name_version

const app_name = Global_Variable.app_name
const app_version = Global_Variable.app_version
const name_version = Global_Variable.name_version

func _ready():
	#Global_Fonction.set_win_load()
	testpersistantfolder()
	Global_Fonction.load_encrypt_file()
	
	#yield(get_tree().create_timer(2), "timeout")
	#Global_Fonction.set_win_normale()
	pass







func testpersistantfolder():
	var dir = Directory.new()
	if dir.dir_exists(simpleCAD_data_dir) == false:
		makepersistantfolder()
		load_environement_config()
	else:
		print("Dossier ", name_version, " trouvé !")
		load_environement_config()

func makepersistantfolder():
	OS.alert(
		Global_Variable.message["first_opening_titre"],
		Global_Variable.message["first_opening_message"]
		)
	var dir = Directory.new()
	dir.open(user_data_dir)
	dir.make_dir(name_version)
	print("Dossier "+ name_version +" créer avec succés")









func load_environement_config():
	var path = simpleCAD_data_dir+"/environement.cfg"
	var config = ConfigFile.new()
	var err = config.load(path)
	if err != OK:
		print("environement.cfg -> non trouvé -> création")
		build_environement_config()
	else: 
		print("environement.cfg -> trouver -> attribution")
		attribut_environement_config()

func build_environement_config():
	var path = simpleCAD_data_dir+"/environement.cfg"
	var config = ConfigFile.new()
	config.set_value("data", "last_user", "Baptiste")
	config.set_value("data", "WWW", 111)
	config.save(path)
	
func attribut_environement_config():
	var path = simpleCAD_data_dir+"/environement.cfg"
	var config = ConfigFile.new()
	config.load(path)
	for data in config.get_sections():
			var last_user = config.get_value(data, "last_user")
			print(last_user)
			#score_data[player_name] = player_score




