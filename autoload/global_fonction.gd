extends Node

func set_win_load():
	OS.window_borderless = true
	OS.window_resizable = false
	OS.set_window_per_pixel_transparency_enabled(true)
	get_tree().get_root().set_transparent_background(true)
	OS.window_size = Vector2(600, 400)
	OS.center_window()
	pass


func set_win_normale():
	OS.window_borderless = false
	OS.window_resizable = true
	OS.set_window_per_pixel_transparency_enabled(false)
	get_tree().get_root().set_transparent_background(false)
	OS.window_size = Vector2(1200, 800)
	OS.center_window()
	OS.set_window_title(str(Global_Variable.name_version+" - "+Global_Variable.current_space))
	pass
