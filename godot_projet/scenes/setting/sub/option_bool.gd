extends Control


export var key = "String"
export var valeur = true

onready var lab_key = get_node("HBoxContainer/Label")
onready var btn_val = get_node("HBoxContainer/CheckButton")
# Called when the node enters the scene tree for the first time.
func _ready():
	lab_key.text = key
	btn_val.pressed = valeur
	pass # Replace with function body.


func set_key(key):
	lab_key.text = key

func set_valeur(valeur):
	btn_val.pressed = valeur


func _on_CheckButton_pressed():
	print("changement de bool")
	pass # Replace with function body.
