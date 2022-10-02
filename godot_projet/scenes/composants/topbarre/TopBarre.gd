extends Control

onready var win_size = Vector2(50, 50)
onready var win_position = Vector2(50, 50)

onready var panel = get_node("%Panel")
onready var btn_mini = get_node("%Btn_Mini")
onready var btn_maxi = get_node("%Btn_Maxi")

func _ready():
	
	Global_Fonction.set_win_normale()


# Signal des boutons WindowActions
func _on_Btn_Close_button_down():
	get_tree().quit()

func _on_Btn_Mini_toggled(button_pressed):
		
	if button_pressed:
		win_size = OS.get_window_size()
		OS.set_window_size(Vector2(win_size.x,50))
	else:
		OS.set_window_size(win_size)

func _on_Btn_Maxi_toggled(button_pressed):
	
	if button_pressed:
		win_position = OS.get_window_position()
		win_size = OS.get_window_size()
		#print("win_position[", win_position, "]")
		#print("win_size[", win_size, "]")
		#OS.set_window_size(OS.get_screen_size())
		#OS.set_window_position(Vector2(0, 0))
		OS.set_window_always_on_top(true)
		OS.window_maximized = true
		OS.window_resizable = false
		#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	else:
		OS.set_window_position(win_position)
		OS.set_window_size(win_size)
		OS.window_resizable = true
		OS.set_window_always_on_top(false)
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Btn_Full_toggled(button_pressed):
	if button_pressed:
		OS.set_borderless_window(false)
		OS.window_fullscreen = !OS.window_fullscreen
	else:
		pass


func tutu():
	var app_mode = Global_Variable.app_mode
	var E_lanceur = get_node("Panel/Espaces/Home")
	var E_CAD = get_node("Panel/Espaces/CAD")
	var E_options = get_node("Panel/Espaces/Options")
	
	E_lanceur.visible = false
	E_CAD.visible = false
	E_options.visible = false

	if app_mode == "Launcher":
		E_lanceur.visible = true

	if app_mode == "CAD":
		E_CAD.visible = true

	if app_mode == "Settings":
		E_options.visible = true

