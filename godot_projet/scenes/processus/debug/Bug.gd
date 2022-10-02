extends Control

func _ready():
	self.modulate = Global_Variable.user_theme["color_user"]
	

onready var label_bits = get_node("VBoxContainer/Bit")
onready var label_win_size = get_node("VBoxContainer/WindowsTaille")

func _process(_delta):
	
	
	
	
	var bits = float(OS.get_static_memory_usage())
	var octet = bits/8
	var mega_octet = float(octet/1000000)
	
	label_bits.text = str("app_memory_usage =  ", mega_octet, " Mo")
	label_win_size.text = str("app_window_size =  ", get_viewport_rect().size)
