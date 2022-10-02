extends Control



func _on_btn_non_button_down():
	self.visible = false
	pass # Replace with function body.


func _on_btn_oui_button_down():
	Global_Fonction.close_app()
	pass # Replace with function body.
