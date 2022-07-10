extends "res://autoload/global_fonction.gd"

onready var seperator = get_node("Panel/CenterContainer/VBoxContainer/Separator")
onready var label_action = get_node("Panel/CenterContainer/VBoxContainer/Label_action")
onready var bar = get_node("Panel/CenterContainer/VBoxContainer/ProgressBar")

func _ready():
	set_win_load()
	testpersistantfolder()
	load_encrypt_file()
	config_user_load()
	config_environnement_load()
	animation()
	build_SimpleCAD()
#	yield(get_tree().create_timer(2), "timeout")
#	set_win_normale()
	pass
	
	
	
	
func animation():
	yield(get_tree().create_timer(2), "timeout")
	seperator.visible = true
	label_action.visible = true
	#bar.visible = true
