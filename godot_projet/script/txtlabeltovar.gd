extends Label

export(String) var connect_to_variable
onready var variable_valeur = Global_Variable.get(connect_to_variable)

func _ready():
	if connect_to_variable == "":
		connect_to_variable = self.text
	
	if self.text in Global_Variable:
		self.text = Global_Variable.get(self.text)
		variable_valeur = self.text
		
func _process(_delta):
	self.text = Global_Variable.get(connect_to_variable)

