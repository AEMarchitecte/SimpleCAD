extends Label


func _input(event):
	self.text = str(event.as_text())
