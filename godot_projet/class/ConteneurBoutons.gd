tool
extends GridContainer

class_name ConteneurBoutons, "res://class/ConteneurBoutons.svg"
signal send_scene
export(int) var identifiant
export(int) var best_child


func _ready():
	self.add_to_group("ConteneurBoutons")
	self.connect("visibility_changed", self, "on_visibility_changed")
	
	actualise_childs()
	if not Engine.editor_hint:
		
		var enfants = self.get_children()
		for btn in enfants:
			btn.set_toggle_mode(true)
			btn.set_enabled_focus_mode(0)
			
		
	if Engine.editor_hint:
# warning-ignore:return_value_discarded
		self.connect("resized", self, "actualise_childs")

func actualise_childs():
	print("Il faut actualiser les enfants :")
	var enfants = self.get_children()
	for x in enfants:
			x.text = x.name
			if x.is_connected("renamed", self, "actualise_childs"):
				print("le bouton [", x.name ,"] est deja connecter")
				pass
			else:
				x.connect("renamed", self, "actualise_childs")
				print("le bouton [", x.name ,"] viens d'étre connecter")





func open_scn(valeur, scene):
	#print("Signal reçu = ",valeur, scene)
	var enfants = self.get_children()
	for btn in enfants:
		if btn.name == valeur:
			pass
		else:
			btn.pressed = false
			
	connect_to_cont_scn(scene)

func connect_to_cont_scn(scene):
	if not Engine.editor_hint:
		var id_local = identifiant
		#print("id local = ", id_local)
		
		#var liste_conteneurscn = get_tree().get_nodes_in_group("ConteneurScenes")
		var succes = false
		for c in get_tree().get_nodes_in_group("ConteneurScenes"):
			if c.identifiant == id_local:
				#print("conteneurs de même ID trouvé !")
				succes = true
# warning-ignore:return_value_discarded
				connect("send_scene", c, "new_scn")
				emit_signal("send_scene", scene)
				
		if succes == false: print("Conteneurs de même ID non trouvé !")

















# Si la visibilié change, alors ...
func on_visibility_changed():
	print("La visibilité du conteneur de boutons [", name ,"] a changer")
	if teste_if_child_pressed() == false:
		print("[", name ,"] na pas d'enfant pressed")
		presse_best_child()


func teste_if_child_pressed():
	var liste_enfants = self.get_children()
	for enfant in liste_enfants:
		if enfant.pressed == true:
			return true
		else:
			return false

func presse_best_child():
	print("Il faut presser l'enfant avec lid [", best_child, "]")
	self.get_child(best_child).pressed = true
	pass
			
		

