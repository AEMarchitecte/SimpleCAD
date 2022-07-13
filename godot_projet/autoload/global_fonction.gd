extends "res://autoload/global_variable.gd"

















func get_external_texture(path):
	var img = Image.new()
	img.load(path)
	var texture = ImageTexture.new()
	texture.create_from_image(img)
	return texture


static func delete_childrens(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()







var storage_path
var zip_file

func unzip(sourceFile,destination):
	zip_file = sourceFile
	storage_path = destination
	
	var gdunzip = load('res://addons/gdunzip/gdunzip.gd').new()
	var loaded = gdunzip.load(zip_file)

	if !loaded:
		print('- Failed loading zip file')
		return false
		
	ProjectSettings.load_resource_pack(zip_file)
	
	var i = 0
	for f in gdunzip.files:
		unzip_file(f)

func unzip_file(fileName):
	var readFile = File.new()
	if readFile.file_exists("res://"+fileName):
		readFile.open(("res://"+fileName), File.READ)
		var content = readFile.get_buffer(readFile.get_len())
		readFile.close()
		
		var base_dir = storage_path + fileName.get_base_dir()
		
		var dir = Directory.new()
		dir.make_dir(base_dir)
		
		var writeFile = File.new()
		writeFile.open(storage_path + fileName, File.WRITE)
		writeFile.store_buffer(content)
		writeFile.close()



func test_file(path):
	var file = File.new()
	if file.file_exists(path):
		print("fichier trouvé à (", path ,")")
		return true






















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



