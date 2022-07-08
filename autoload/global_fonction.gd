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

















func load_encrypt_file():
	var path = Global_Variable.simpleCAD_data_dir+"/licence.cfg"
	var array = OS.get_unique_id().sha256_buffer()
	var config = ConfigFile.new()
	var err = config.load_encrypted(path, PoolByteArray(array))
	if err != OK :
		print("licence.cfg -> pas trouver -> création")
		config.set_value("data", "UID", OS.get_unique_id())
		config.set_value("data", "nombre_ouverture", 500)
		config.save_encrypted(path, PoolByteArray(array))
	else :
		print("licence.cfg -> trouver")
		for data in config.get_sections():
			var UID = config.get_value(data, "UID")
			var nombre_ouverture = config.get_value(data, "nombre_ouverture")
			#print("UID = ", UID)
			#print("nombre_ouverture = ", nombre_ouverture)
			if nombre_ouverture <= 0:
				OS.alert(
					Global_Variable.message["more_opening_message"],
					Global_Variable.message["more_opening_titre"]
				)
				get_tree().quit()
			nombre_ouverture = nombre_ouverture-1
			#print("nombre_ouverture-1 = ", nombre_ouverture)
			config.set_value("data", "nombre_ouverture", nombre_ouverture)
			config.save_encrypted(path, PoolByteArray(array))
		
