extends Control

class_name ConteneurScenes, "res://class/ConteneurScenes.svg"

export(int) var identifiant
export(String, "Remplace", "Superpose") var mode
var current_scn = PackedScene


func _ready():
	self.add_to_group("ConteneurScenes")

func _process(_delta):
	if self.get_child_count() == 0:
		self.visible = false
	else: 
		self.visible = true

func new_scn(scene):
	#print("Signal reçu, il faut charger la scene", scene)
	
	if current_scn == scene:
		for scn in self.get_children(): scn.queue_free()
		current_scn = PackedScene
	else : 
		current_scn = scene
		if mode == "Remplace":
			for scn in self.get_children(): scn.queue_free()
			var instance = scene.instance()
			add_child(instance)

func kill_scene(scene):
	print("Signal reçu, il faut tuer la scene", scene)
	for scn in self.get_children(): scn.queue_free()

