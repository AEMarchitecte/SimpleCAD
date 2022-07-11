extends Button



var png_link = "https://filedn.com/lxyk5BtcgOIYu75M2RYFSm4/myApp/SimpleCAD/Capture.png"
var version_link = "https://filedn.com/lxyk5BtcgOIYu75M2RYFSm4/myApp/SimpleCAD/version.txt"

var png_path = "user://Capture.png"
var version_path = "user://version.txt"

var http_request: HTTPRequest

func _ready():
	
	var node = get_parent().get_node("TextureRect")
	var new_img = get_external_texture(png_path)
	node.set_texture(new_img)
	
	
	_verify_gamefiles()
	self.disabled = true
	
func file_exists(path: String) -> bool:
	var dir =Directory.new()
	return dir.file_exists(path)
	
	
func _verify_gamefiles():
	# Check if files are complete
	if file_exists(png_path) && file_exists(version_path):
		_download_file(version_link, version_path, true)
	else:
		_check_integrity()
		
func _download_file(link: String, path: String, just_version: bool):
	http_request = HTTPRequest.new()
	add_child(http_request)
	
	self.text = "Télechargement " + str(path.get_file())
	http_request.connect("request_completed", self, "_install_file", [path, just_version])
	
	# Handle Errors
	var error = http_request.request_raw(link)
	if error != OK:
		self.text = "Eurreur de chargement: " + str(error)
		
func _install_file(_result, _response_code, _headers, body, path, just_version: bool):
	
	if just_version:
		var new_version = str(body.get_string_from_utf8())
		_compare_version(new_version)
		return
		
	var dir = Directory.new()
	dir.remove(path)
	
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_buffer(body)
	file.close()
	_check_integrity()
	
func _check_integrity():
	if !file_exists(png_path):
		_download_file(png_link, png_path, false)
		print("Création de png")
		return
	
	if !file_exists(version_path):
		_download_file(version_link, version_path, false)
		var dir = Directory.new()
		dir.remove(png_path)
		print("Création de version")
		return
	

	self.text = "Suivant"
	self.disabled = false
	
func _compare_version(new_version):
	var file = File.new()
	file.open(version_path, File.READ)
	var cur_version = file.get_as_text();
	file.close()
	
	
	if int(new_version) == int(cur_version):
		print("Version à jour !")
	
	if int(new_version) > int(cur_version):
		print("version actuelle = ", cur_version)
		print("version nouvelle = ", new_version)
		var dir = Directory.new()
		dir.remove(version_path)
	_check_integrity()








func _on_Button_pressed():
	_start_game()
	
	
func _start_game():
	#get_tree().reload_current_scene()
	var node = get_parent().get_node("TextureRect")
	var new_img = get_external_texture(png_path)
	node.set_texture(new_img)
	
	yield(get_tree().create_timer(2), "timeout")
	get_tree().quit()
	
func get_external_texture(path):
	var img = Image.new()
	img.load(path)
	var texture = ImageTexture.new()
	texture.create_from_image(img)
	return texture
