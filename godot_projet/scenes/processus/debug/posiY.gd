extends Label

func _input(event):
	if event is InputEventMouseMotion:
		self.text = str("curseur_position Y : ", event.position.y)
