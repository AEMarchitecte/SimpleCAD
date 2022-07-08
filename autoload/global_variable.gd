extends Node

# variable d'application
const app_name = "SimpleCAD"
const app_version = "0.0.1"
const name_version = app_name+" "+app_version
onready var user_data_dir = OS.get_user_data_dir()
onready var simpleCAD_data_dir = user_data_dir+"/"+name_version
onready var nombre_ouverture = 0


# variable de la machine
var machine_id = OS.get_unique_id()
var locale = OS.get_locale()
var model_name = OS.get_name()



# variable d'espaces
onready var current_space = "lanceur"


var message = {
	first_opening_titre = app_name + " vas créer un dossier sur votre ordinateur histoire de ne pas se perdre. Ne vous inquiété pas nous mettrons tout dedans et n'en créerons pas d'autre ",
	first_opening_message = "Vous ouvrez " + name_version + " pour la premier",
	more_opening_titre = "Attention",
	more_opening_message = "Vous avez ouvert SimpleCAD plus de 5 fois. Si cette application vous plaît merci d'acheter une licence",
	Alert_XX = 42,
	}









func _ready():
	#global_variable_printing()
	pass

func global_variable_printing():
	print("--- global variable printing ---")
	print("Localisation : ", locale)
	print("Plateforme : ", model_name)
	print("UID de la machine : ", machine_id)
	print("--- --- ---")
