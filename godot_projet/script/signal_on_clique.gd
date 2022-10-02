extends Node
signal Speek
export(String) var Say

func _ready():
	self.connect("button_down", self, "speek")

func speek():
	print("Il faut emettre le signal [", Say, "]")
	self.connect("Speek", Global_Signal, "entendre")
	emit_signal("Speek", Say)
	


