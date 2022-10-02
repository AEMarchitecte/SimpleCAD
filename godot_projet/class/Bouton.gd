tool
extends Button

class_name Bouton, "res://class/Bouton.svg"

signal clique
signal declique

export(PackedScene) var scene


func _get_configuration_warning() -> String:
	if scene == null:
		return "Ce bonton doit être lié à une scene"
	else:
		return ""

func _ready(): 
	self.connect("toggled", self, "status")

func status(button_pressed):
	var parent = get_parent()
	var valeur = self.name
	
	if button_pressed == true:
		print("Pressage de [",valeur, "]")
		self.connect("clique", parent, "open_scn")
		emit_signal("clique", valeur, scene)
	if button_pressed == false:
		print("De-Pressage de [",valeur, "]")
		self.connect("declique", parent, "close_scn")
		emit_signal("declique", valeur, scene)
	
