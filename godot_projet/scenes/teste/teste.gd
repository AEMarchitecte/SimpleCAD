extends Node

onready var button = get_node("Button")

func _ready():
	
	button.text = "start"
	button.connect("pressed", self, "_start")
	
	buil_phase("")

func buil_phase(valeur):
	
	if valeur == "pas1":
		button.text = "start pas 1"
		button.connect("pressed", self, "_pas1")

	if valeur == "pas2":
		button.text = "start pas 2"
		button.connect("pressed", self, "_button_pressed")


func _start():
	buil_phase("pas1")

func _pas1():
	buil_phase("pas2")
