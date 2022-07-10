extends Control

onready var nb_1 = 8

func _ready():
	if etape1() == true:
		print("0")
	


func etape1() -> bool :
	if nb_1 == 1:
		return true
	else:
		return false
		
