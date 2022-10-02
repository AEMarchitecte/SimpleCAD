extends Button

signal Dire

export(PackedScene) var scene
export(String) var destination

func _ready():
	toggle_mode = true
	print("Le bouton [", name, "] à etre connecté")
	self.connect("toggled", self, "status")
	
	
func status(button_pressed):
	var id = name
	if button_pressed == true:
		print("Pressage de [",name, "]")
		Global_Fonction.Open_PackedScene_at(scene, destination, id)
		self.connect("Dire", Global_Signal, "entendre")
		emit_signal("Dire", id)
	
	if button_pressed == false:
		self.disconnect("Dire", Global_Signal, "entendre")
#		print("De-Pressage de [",name, "]")
#		Global_Fonction.Close_PackedScene_at(scene, destination, id)
		return
