extends Control

func _ready():
	connect("gui_input", self, "_move")

var following = false
var drag_start_posi = Vector2()


func _move(event):
	#print(event)
	if event is InputEventMouseButton:
		if event.get_button_index() == 1:
			following = !following
			drag_start_posi =  get_local_mouse_position() 
			
func _process(_delta):
	if following:
		OS.set_window_position(OS.window_position + get_global_mouse_position() - drag_start_posi)
