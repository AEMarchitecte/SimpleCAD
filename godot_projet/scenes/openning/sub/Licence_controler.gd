extends "res://autoload/global_fonction.gd"


onready var btn = get_node("box/HBoxContainer/Button")
onready var key = get_node("box/HBoxContainer/key")

onready var box = get_node("box")

func _ready():
	box.visible = false
	Global_Variable.build_phase = "Contrôle de la licence . . ."
	yield(get_tree().create_timer(1), "timeout")
	
	
	if key_is_valide() == true:
		#Global_Variable.build_phase = "Clef de licence valide !"
		#yield(get_tree().create_timer(2), "timeout")

		var node_openning = get_node("/root/Openning")
		node_openning.build_process("update_app")
	
	else :
		if licence_controler() == true:
			var nb = Global_Variable.nombre_ouverture+1
			nb = 5-nb
			Global_Variable.build_phase = str("Il reste ", nb, " ouvertures")
			yield(get_tree().create_timer(2), "timeout")
			
			var node_openning = get_node("/root/Openning")
			node_openning.build_process("update_app")
			
		if licence_controler() == false && key_is_valide() == false:
			print("tout est faut")
			box.visible = true

			yield(btn, "pressed")
			var key_enter = key.text
			licence_key_save(key_enter)

			var node_openning = get_node("/root/Openning")
			node_openning.build_process("licence")










func licence_controler() -> bool:
	print("Nombre d'ouverture avant = ", Global_Variable.nombre_ouverture)
	var nb = Global_Variable.nombre_ouverture+1
	
	var array = OS.get_unique_id().sha256_buffer()
	var config = ConfigFile.new()
	config.load_encrypted(cfg_lic_path, PoolByteArray(array))
	config.set_value("data", "nombre_ouverture", nb)
	config.save_encrypted(cfg_lic_path, PoolByteArray(array))
	print("Actualisation du nombre d'ouverture...")
	print("Nombre d'ouverture après = ", nb)
	
	if nb > 2:
		return false
	else:
		return true

func licence_key_save(key_enter):
	Global_Variable.licence_key = key_enter
	var array = OS.get_unique_id().sha256_buffer()
	var config = ConfigFile.new()
	config.load_encrypted(cfg_lic_path, PoolByteArray(array))
	config.set_value("data", "licence_key", key_enter)
	config.save_encrypted(cfg_lic_path, PoolByteArray(array))
	print("Enregistrement de la licence_key = ", key_enter)

func key_is_valide() -> bool:
	var key_register = Global_Variable.licence_key
	var key_true = "1234"
	print("key_register = ", key_register)
	print("key_true = ", key_true)
	if key_register == key_true:
		return true
	else:
		return false
