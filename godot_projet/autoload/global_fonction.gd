extends "res://autoload/global_variable.gd"
























































### Fonctions lié à la fenetre

func set_win_load():
	OS.window_borderless = true
	OS.window_resizable = false
	OS.set_window_per_pixel_transparency_enabled(true)
	get_tree().get_root().set_transparent_background(true)
	OS.window_size = Vector2(600, 350)
	OS.center_window()
	pass


func set_win_normale():
	OS.window_borderless = false
	OS.window_resizable = true
	OS.set_window_per_pixel_transparency_enabled(false)
	get_tree().get_root().set_transparent_background(false)
	OS.window_size = Vector2(1200, 800)
	OS.center_window()
	OS.set_window_title(str(name_version+" - "+current_space))
	pass



