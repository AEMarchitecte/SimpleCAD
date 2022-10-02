extends Node

# Attribution des variables ...
onready var current_space = Global_Variable.current_space

# Attribution des variables de menus...
onready var path_btn_menus = "PilePrincipale/Panel/TopBarre/HBoxContainer/Menus/"
onready var menu1 = get_node(path_btn_menus + "Menu 1")
onready var menu2 = get_node(path_btn_menus + "Menu 2")
onready var menu3 = get_node(path_btn_menus + "Menu 3")
onready var liste_btn_menus = [menu1, menu2, menu3]


# Attribution des variables de conteneur d'espace ...
onready var path_btn_esp = "PilePrincipale/Panel/TopBarre/HBoxContainer/Buttons Espaces/"
onready var btns_esp_lanceur = get_node(path_btn_esp + "Lanceur")
onready var btns_esp_CAD = get_node(path_btn_esp + "CAD")
onready var btns_esp_options = get_node(path_btn_esp + "Option")
onready var liste_btns_esp = [btns_esp_lanceur, btns_esp_CAD, btns_esp_options]


func _ready():
	Global_Fonction.set_win_normale()
	Global_Fonction.build_theme()
	set_app_mode(current_space)
	
	
func set_app_mode(current_space):
	print("Current_Space[", current_space, "]")
	
	if current_space == "lanceur" or current_space == "":
		masque_menus()
		masque_liste_btns_esp()
		btns_esp_lanceur.visible = true
		clear_menus()
		make_menus_Lanceur()
		
	
	if "CAD" in current_space:
		masque_menus()
		masque_liste_btns_esp()
		btns_esp_CAD.visible = true
	
	if current_space == "Organiser":
		masque_menus()

		clear_menus()
		make_menus_Organiser()
	
	if current_space == "Dessiner":
		masque_menus()


		clear_menus()
		make_menus_Dessiner()
		
	if current_space == "Publier":
		masque_menus()
		
		clear_menus()
		make_menus_Publier()
	
	
	if current_space == "Options":
		print("il faut activer les options")
		#masque_menus()
		#masque_esp_btn()
		#btn_esp_fichier.visible = true
		#btn_esp_application.visible = true
#		if Global_Variable.file_open == false:
#			btn_esp_fichier.disabled = true
#		btn_esp_application.pressed = true
#		var conteneur_esp = get_node("/root/SimpleCAD/PilePrincipale/ConteneurEspaces")
#		var scene = load("res://scenes/espaces/options/application/Application.tscn")
#		var instance = scene.instance()
#		conteneur_esp.add_child(instance)


	







# Mini actions
func masque_liste_btns_esp():
	for boite in liste_btns_esp: 
		boite.visible = false

func masque_menus():
	for menu in liste_btn_menus:
		menu.visible = false
		
func clear_menus():
	for menu in liste_btn_menus:
		menu.get_popup().clear()


func make_menus_Lanceur():
	menu1.visible = true
	menu1.text = "Fichier"
	menu1.get_popup().add_item("Nouveau")
	menu1.get_popup().add_item("Ouvrir")
	menu1.get_popup().add_separator()
	menu1.get_popup().add_item("Quitter")
	menu1.get_popup().connect("id_pressed", self, "menus_actions")
	
	
func make_menus_Organiser():
	menu1.visible = true
	menu1.text = "Organiser"
	menu1.get_popup().add_item("texte")
	
	menu2.visible = true
	menu2.text = "Organiser"
	menu2.get_popup().add_item("texte")
	
	menu3.visible = true
	menu3.text = "Organiser"
	menu3.get_popup().add_item("texte")


func make_menus_Dessiner():
	menu1.visible = true
	menu1.text = "Dessiner"
	menu1.get_popup().add_item("texte")
	
	menu2.visible = true
	menu2.text = "Dessiner"
	menu2.get_popup().add_item("texte")
	
	menu3.visible = true
	menu3.text = "Dessiner"
	menu3.get_popup().add_item("texte")


func make_menus_Publier():
	menu1.visible = true
	menu1.text = "Publier"
	menu1.get_popup().add_item("texte")
	
	menu2.visible = true
	menu2.text = "Publier"
	menu2.get_popup().add_item("texte")
	
	menu3.visible = true
	menu3.text = "Publier"
	menu3.get_popup().add_item("texte")
	
	
#attribut des fonctions à chaque menus
func menus_actions(valeur):
	
	if current_space == "lanceur" and menu1.text == "Fichier":
		if valeur == 0:
			print("nouveau fichier créé")
			set_app_mode("CAD")
		if valeur == 3:
			get_tree().quit()

