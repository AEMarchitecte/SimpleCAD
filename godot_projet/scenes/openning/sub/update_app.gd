extends Label



var version_link = "https://filedn.com/lxyk5BtcgOIYu75M2RYFSm4/myApp/SimpleCAD/version.txt"
var app_link = "https://filedn.com/lxyk5BtcgOIYu75M2RYFSm4/myApp/SimpleCAD/SimpleCAD.pck"

var version_path = "user://version.txt"
var app_path = "user://SimpleCAD.pck"

var http_request: HTTPRequest

func _ready():
	
	Global_Variable.build_phase = "Recherche de mises à jours . . ."
	yield(get_tree().create_timer(1), "timeout")
	
	_verify_gamefiles()
	
	
	
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
	
	self.visible = true
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
	
	self.text = " "
	
	remplace_pkc()

	
func _compare_version(new_version):
	var file = File.new()
	file.open(version_path, File.READ)
	var cur_version = file.get_as_text();
	file.close()
	
	
	if int(new_version) == int(cur_version):
		Global_Variable.reload_app = false
		print("Version à jour !")
	
	if int(new_version) > int(cur_version):
		Global_Variable.reload_app = true
		print("Version pas à jour !")
		print("version actuelle = ", cur_version)
		print("version nouvelle = ", new_version)
		var dir = Directory.new()
		dir.remove(version_path)
	_check_integrity()
	
	
	
func remplace_pkc():
	var old_pck_path = "/Applications/SimpleCAD.app/Contents/Resources/SimpleCAD.pck"
	
	
	if Global_Fonction.test_file(app_path):
		self.text = str(OS.get_executable_path())
		
	if Global_Fonction.test_file(old_pck_path):
		self.text = "Chemin trouvé = " + old_pck_path
	else:
		self.text = "Chemin non touver"
		
		
	var dirrr = Directory.new()
	if dirrr.copy(app_path, old_pck_path) == OK:
		self.text = "copie ok"
	else: 
		self.text = "pas copier"
		
		
	if Global_Variable.reload_app == true:
		Global_Variable.build_phase = "SimpleCad redémarre..."
		yield(get_tree().create_timer(2), "timeout")
		#OS.execute(OS.get_executable_path(), [], false)
		#yield(get_tree().create_timer(1), "timeout")
		#get_tree().quit()
		get_tree().reload_current_scene()
	else:
		Global_Variable.build_phase = "Version à jour !"
		yield(get_tree().create_timer(1), "timeout")
		var node_openning = get_node("/root/Openning")
		node_openning.build_process("environnement")

