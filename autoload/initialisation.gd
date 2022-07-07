extends Node

onready var user_data_dir = OS.get_user_data_dir()

const app_name = Global_Variable.app_name
const app_version = Global_Variable.app_version
const name_version = Global_Variable.name_version

func _ready():
	Global_Fonction.set_win_load()
	testpersistantfolder()
	
	
	
	yield(get_tree().create_timer(2), "timeout")
	
	Global_Fonction.set_win_normale()
	pass

func testdeMethod():

	var data_dir = OS.get_data_dir()
	print(data_dir)
	
	var user_data_dir = OS.get_user_data_dir() + OS.get_config_dir()
	print(user_data_dir)
	
	var unique_id= OS.get_unique_id()
	print(unique_id)
	
	var system_dir = OS.get_system_dir(2, true)
	print(system_dir)
	
	var executable_path = OS.get_executable_path()
	print(executable_path)
	
	var locale = OS.get_locale() + OS.get_locale_language()
	print(locale)
	
	var model_name = OS.get_model_name() + OS.get_name() 
	print(model_name)
	
	#OS.alert("mesage de l'alert", "titre")
	
	var time = OS.get_time()
	print(time)
	pass


func testpersistantfolder():
	var dir = Directory.new()
	if dir.dir_exists(user_data_dir+"/"+name_version) == false:
		makepersistantfolder()
	else:
		print("Dossier ", name_version, " trouvé !")
		#OK super mais il faut vérifier ça structure du dossier
		
		
		


func makepersistantfolder():
	OS.alert(Global_Variable.app_name + " vas créer un dossier sur votre ordinateur !", "Vous ouvrez pour la premier")
	var dir = Directory.new()
	dir.open(user_data_dir)
	dir.make_dir(name_version)
	print("Dossier "+ name_version +" créer avec succés")
