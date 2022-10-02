extends "res://autoload/global_fonction.gd"


func _ready():
	pass
	


func _on_Button_button_down():
	get_node("/root/SimpleCAD").set_app_mode("CAD")
	pass # Replace with function body.
