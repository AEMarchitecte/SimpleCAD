extends Button

func _ready():
	self.connect("pressed", self, "_quit")

func _quit():
	get_tree().quit()
