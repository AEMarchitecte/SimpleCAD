extends Node


# variable d'application
onready var app_name = "SimpleCAD"
onready var app_version = "0.01"
onready var name_version = app_name+" "+app_version
onready var user_data_dir = OS.get_user_data_dir()
onready var simpleCAD_data_dir = user_data_dir+"/"+name_version
onready var nombre_ouverture = 0
onready var build_message = "..."

const cfg_env_name = "environement.cfg"
const cfg_use_name = "utilisateurs.cfg"
const cfg_lic_name = "licence.cfg"

onready var cfg_env_path = simpleCAD_data_dir+"/"+cfg_env_name
onready var cfg_use_path = simpleCAD_data_dir+"/"+cfg_use_name
onready var cfg_lic_path = simpleCAD_data_dir+"/"+cfg_lic_name


# variable de la machine
var machine_id = OS.get_unique_id()
var locale = OS.get_locale()
var model_name = OS.get_name()


# variable d'espaces
onready var current_space = "lanceur"


var message = {
	first_opening_titre = str(app_name) + " vas créer un dossier sur votre ordinateur histoire de ne pas se perdre. Ne vous inquiété pas nous mettrons tout dedans et n'en créerons pas d'autre ",
	first_opening_message = "Vous ouvrez " + str(name_version) + " pour la premier",
	more_opening_titre = "Attention",
	more_opening_message = "Vous avez ouvert SimpleCAD plus de 5 fois. Si cette application vous plaît merci d'acheter une licence",
	}







### variable d'utilisateur ###

var defaut_user_identity = {
	mane = "User0",
	birsday = str(OS.get_datetime()),
	}
var defaut_user_shortcuts = {
	copy = "c",
	past = "v",
	scale = "e",
	rotation = "r",
	translate = "t",
	miroir = "y",
	cute = "k",
	}
var defaut_user_theme = {
	app_color_pp = "c",
	app_color_sp = "c",
	app_color_user = "c",
	}
var defaut_user_settings = {
	unit_esp_drawing = "cm",
	unit_esp_publiching = "mm",
	}

var last_user = "User0"
var current_user = "User0"
var user_shortcut = defaut_user_shortcuts
var user_theme = defaut_user_theme

var user_recent_files = ""

