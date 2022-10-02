extends Control

#
export(int) var current_nav_level = 0 setget update_nav_level

#Definition des boites 
onready var box_tools = get_node("Panel/General/Tools")


#Definition des boutons
onready var btn_home = get_node("Panel/General/Nav/Home")
onready var btn_retour = get_node("Panel/General/Nav/Retour")


func _ready():
	#get_app_mode()
	#buils_tools()
	
	connect_tools_to_nav()
	

func connect_tools_to_nav():
	for btn in box_tools.get_children():
		btn.connect("button_down", self, "incremente_nav")
		print("[", btn.name, "] is connected to [", self.name, "]")
		
func incremente_nav():
	update_nav_level(1)

func update_nav_level(valeur):
	if valeur == 0:
		btn_home.disabled = true
		btn_retour.visible = false
	if valeur == 1:
		btn_home.disabled = false
	


func _on_Home_button_down():
	update_nav_level(0)
