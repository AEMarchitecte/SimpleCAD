extends OptionButton


func _ready():
	#print(self.text)
	pass

func _on_AppMode_selector_item_selected(index):
	var val = self.text
	Global_Variable.app_mode = str(val)
	#print("Global_variable.app_mode set [", val, "]")

