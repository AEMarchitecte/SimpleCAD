extends "res://autoload/global_variable.gd"

func _process(_delta):
	Surcharge_btn()
	
	pass


func test_integrity():
	OS.alert("yiyiyi", "Alert!")
	pass











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

func load_scene_at(path, node):
	var scene_resource = load(path)
	var next_scene = scene_resource.instance()
	node.add_child(next_scene)
	
	
	
	
func Open_PackedScene_at(scene, _destination, id):
	var scene_instance = scene.instance()
	var node = get_node(_destination)
	node.add_child(scene_instance)
	scene_instance.add_to_group(id)
	
func Close_PackedScene_at(_scene, _destination, id):
	var liste = get_tree().get_nodes_in_group(id)
	for n in liste: n.queue_free()







func test_file(path):
	var file = File.new()
	if file.file_exists(path):
		print("fichier trouvé à (", path ,")")
		return true





func attent(x: int):
	yield(get_tree().create_timer(x), "timeout")















### Fonctions lié à la fenetre

func set_win_load():
	OS.window_borderless = true
	OS.window_resizable = false
	OS.set_window_per_pixel_transparency_enabled(true)
	get_tree().get_root().set_transparent_background(true)
	OS.window_size = Vector2(600, 350)
	OS.center_window()


func set_win_normale():
	OS.window_borderless = true
	OS.window_resizable = true
	OS.set_window_per_pixel_transparency_enabled(true)
	get_tree().get_root().set_transparent_background(true)
	OS.window_size = Vector2(1000, 600)
	OS.min_window_size = Vector2(800, 600)
	OS.center_window()
	OS.set_window_title(str(name_version+" - "+current_space))
	
func mini_win():
	OS.window_resizable = true
	OS.set_window_per_pixel_transparency_enabled(false)
	get_tree().get_root().set_transparent_background(false)
	OS.window_borderless = false
	OS.set_window_minimized(true)

func maxi_win():
	OS.window_resizable = true
	OS.set_window_per_pixel_transparency_enabled(false)
	get_tree().get_root().set_transparent_background(false)
	OS.window_borderless = false
	OS.set_window_minimized(true)

func close_app():
	get_tree().quit()
























### Gestion de l'apparence :

func build_theme():
	# Localisation du theme ...
	var theme = load("res://graphique/theme/SimpleCAD.theme")
	
	# Attribution des couleurs ...
	var color_text = Global_Variable.user_theme["color_text"]
	var color_fond = Global_Variable.user_theme["color_fond"]
	var color_user = Global_Variable.user_theme["color_user"]
	
	# Attribution de la couleur des textes du theme ...
	theme.set_color("font_color", "Label", color_text)
	theme.set_color("font_color", "Button", color_text)
	theme.set_color("font_color_focus", "Button", color_user)
	
	# Attribution de la couleur de fond des panneaux ...
	var panel1 = load("res://graphique/theme/panels/Panel_arrondi_10px.stylebox")
	var panel2 = load("res://graphique/theme/panels/Panel_arrondi_10px_bas.stylebox")
	var panel3 = load("res://graphique/theme/panels/Panel_arrondi_10px_haut.stylebox")
	var panel4 = load("res://graphique/theme/panels/Panel_arrondi_20px.stylebox")
	var panel5 = load("res://graphique/theme/panels/Panel_carre.stylebox")
	var panel6 = load("res://graphique/theme/panels/Panel_arrondi_10px_ombre.stylebox")

	var panels_liste = [panel1, panel2, panel3, panel4, panel5, panel6]
	for pan in panels_liste:
		pan.set_bg_color(color_fond)
		
		
		
func Surcharge_btn():
	
	var color_p1 = Global_Variable.user_theme["color_text"]
	var _color_p2 = Global_Variable.user_theme["color_fond"]
	var color_user = Global_Variable.user_theme["color_user"]

	var btn_barre = get_tree().get_nodes_in_group("bnt_icone")

	for i in btn_barre:

		i.set_modulate(color_p1)
		i.set_focus_mode(0)

		if i.disabled == true:
			pass

		elif i.is_hovered():
			i.set_modulate(color_user)

		elif i.is_pressed():
			i.set_modulate(color_user)

	











		
		
		
		
		
		
		
		
