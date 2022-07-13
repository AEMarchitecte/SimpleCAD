extends Button

var version_link = "https://filedn.com/lxyk5BtcgOIYu75M2RYFSm4/myApp/SimpleCAD/version.txt"
var app_link = "https://filedn.com/lxyk5BtcgOIYu75M2RYFSm4/myApp/SimpleCAD/SimpleCAD.pck"

var version_path = "user://version.txt"
var app_path = "user://SimpleCAD.pck"

var http_request: HTTPRequest

func _ready():
	_verify_gamefiles()
	self.disabled = true
	
	
func file_exists(path: String) -> bool:
	var dir =Directory.new()
	return dir.file_exists(path)
	
	
func _verify_gamefiles():
	# Check if files are complete
	if file_exists(app_path) && file_exists(version_path):
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
	
	if !file_exists(version_path):
		_download_file(version_link, version_path, false)
		var dir = Directory.new()
		dir.remove(app_path)
		print("Création de version")
		return
		
	if !file_exists(app_path):
		_download_file(app_link, app_path, false)
		print("Création du zip")
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
		print("Version pas à jour !")
		print("version actuelle = ", cur_version)
		print("version nouvelle = ", new_version)
		var dir = Directory.new()
		dir.remove(version_path)
	_check_integrity()








func _on_Button_pressed():
	if Global_Fonction.test_file(app_path):
		print(OS.get_executable_path())
		var btn = get_tree().get_nodes_in_group("Build phase")
		for bt in btn:
			print(bt)
			bt.text = "cococ"
		
		#var dir = Directory.new()
		#dir.copy(app_path, "res://sprite_image.tex")
		pass
	#dir.file_exists(app_path)
	#OS.shell_open(OS.get_user_data_dir() + "/SimpleCAD.dmg")
	#Global_Fonction.unzip(app_path, "user://SimpleCAD.app")
#	var path = OS.get_user_data_dir() + "/SimpleCAD.dmg"
	#print(path)
#	var output = []
#	OS.execute("cd", [path], false, output)
#	for line in output:
#		print(line)
	#print(OS.execute(app_path, [], false))

	#_remplace_pkc()
	pass
	
	
func _remplace_pkc():
	
	
	
	_reload_app()
	
func _reload_app():
	if !file_exists("/Applications/SimpleCAD.app"):
		OS.execute(OS.get_executable_path(), [], false)
		get_tree().quit()

