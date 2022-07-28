extends Node

onready var settings = {
	
	"Général" : {
		"option1" : 3,
		"option2" : 5,
		"option3" : 3,
		"option4" : 3,
		"suboption3" : false,
		"suboption1" : true,
		"option5" : 3,
		"option6" : 3,
		"option7" : 3,
		
	},
	
	"Affichage" : {
		"suboption1" : false,
		"suboption655" : true,
		"suboption5666" : false,
	},
	
	"Dessin" : {
		"suboption1" : true,
	},
	
	"Enregistrement" : {
		"Enregistrer le fichier automatiquement" : true,
		"Enregistrer le fichier automatiquement toutes les ... minutes" : 10,
	},
	
	"Utilisateur" : {
		"suboption1" : false,
	},
	
}









onready var tabs_container = get_node("TabContainer")

func _ready():
	
	add_settings_tabs()
	add_sub_setting()
	
	#print(settings.values())



func add_settings_tabs():
	#var tabs_titres = settings.values()
	var tabs_titres = settings.keys()
	for tab in tabs_titres:
		var new_tab = Tabs.new()
		tabs_container.add_child(new_tab)
		new_tab.set_name(str(tab))
		new_tab.set_anchors_preset(15)
		



func add_sub_setting():
	var menus = tabs_container.get_children()
	for submenu in menus:

		var name = submenu.get_name()
		#print(name)
		
		var option_liste_container = VBoxContainer.new()
		submenu.add_child(option_liste_container)
		option_liste_container.set_anchors_preset(15)
		option_liste_container.set_margins_preset(Control.PRESET_WIDE)
		var boite_idem = submenu.get_child(0)
		#print(boite_idem)
		boite_idem.set_anchors_preset(15)
		
		var current_option_dict = settings.get(name)
		for key in current_option_dict:
			var valeur = current_option_dict.get(key)
			#print("La clef [", key, "] contient la valeur [", valeur,"]")
			if valeur is bool:
				#print("c'est un bool")
				add_option_bool(key, valeur, boite_idem)
			if valeur is int:
				#print("c'est un int")
				pass
		
		


func add_option_bool(key: String, valeur: bool, node: Node):
	var scn_path = load("res://scenes/setting/sub/option_bool.tscn")
	var instance = scn_path.instance()
	node.add_child(instance)
	instance.set_key(key)
	instance.set_valeur(valeur)
	pass

