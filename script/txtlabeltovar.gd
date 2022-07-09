extends Label


func _ready():
	if self.text in Global_Variable:
		self.text = Global_Variable.get(self.text)

