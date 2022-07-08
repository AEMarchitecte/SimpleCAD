extends Node


func _ready():
	testdeMethod()
	pass


func testdeMethod():

	var data_dir = OS.get_data_dir()
	print(data_dir)
	
	var user_data_dir = OS.get_user_data_dir() + OS.get_config_dir()
	print(user_data_dir)
	
	var unique_id= OS.get_unique_id()
	print(unique_id)
	
	var system_dir = OS.get_system_dir(2, true)
	print(system_dir)
	
	var executable_path = OS.get_executable_path()
	print(executable_path)
	
	var locale = OS.get_locale() + OS.get_locale_language()
	print(locale)
	
	var model_name = OS.get_model_name() + OS.get_name() 
	print(model_name)
	
	#OS.alert("mesage de l'alert", "titre")
	
	var time = OS.get_time()
	print(time)
	pass
