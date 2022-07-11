extends Control


func _ready():
	Global_Fonction.set_win_normale()
	yield(get_tree().create_timer(1), "timeout")
	get_tree().quit()
	pass
