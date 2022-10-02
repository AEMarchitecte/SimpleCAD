extends "res://autoload/global_fonction.gd"

signal notification

func entendre(valeur):
	print("Le Global_Signal à ententu [", valeur, "]")
	
	if valeur == "quit":
		get_node("/root/SimpleCAD/Processus/Quitter").visible = true
	if valeur == "mini":
		mini_win()
	if valeur == "maxi":
		OS.set_window_maximized(true)
		
		
	if valeur == "help":
		var HelpNode = get_node("/root/SimpleCAD/Processus/Help")
		HelpNode.visible = true
		
		
		
		
		
		
		
		
		
		
		
		
	if valeur == "lanceur":
		get_node("/root/SimpleCAD").set_app_mode(valeur)
		
	if valeur == "Organiser":
		get_node("/root/SimpleCAD").set_app_mode(valeur)

	if valeur == "Dessiner":
		get_node("/root/SimpleCAD").set_app_mode(valeur)
		
	if valeur == "Publier":
		get_node("/root/SimpleCAD").set_app_mode(valeur)
		
		
		
		
	if valeur == "options":
		#set_app_mode("options")
		pass

func propage_new_app_mode():
	var topBarre = get_node("/root/Global_Application/UI/Window/TopBarre")
	self.connect("notification", topBarre, "tutu")
	emit_signal("notification")
	self.disconnect("notification", topBarre, "tutu")
