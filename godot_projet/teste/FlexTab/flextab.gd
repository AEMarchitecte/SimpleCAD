tool
extends GridContainer
class_name FlexTabControler, "res://class/FlexTabControler.svg"

signal Action

export(bool) var master_visibility setget update_visi
export(NodePath) var defaut_child

onready var child_list = get_children()

func update_visi(stat):
	master_visibility = stat
	if stat == true: 
		self.visible = true
	else:
		self.visible = false

func _ready():
	
	#for child in child_list:
		#print(child.name)
	connect("visibility_changed", self, "propagation")
	emit_signal("visibility_changed")
	
	var nombre_danf = self.get_child_count()
	print(nombre_danf)
	for x in child_list:
		print(x.name)


func propagation():
	
	if Engine.editor_hint:
		print("propagation...")
	pass
	
	
	
	
var my_property = get_children()

func _get_property_list():
	
	var properties = []
	properties.append({
		name = "sub_button_list",
		type = TYPE_NIL,
		hint_string = "btn_",
		usage = PROPERTY_USAGE_GROUP | PROPERTY_USAGE_SCRIPT_VARIABLE
	})
	
	var x = 0
	while x != self.get_child_count():
		properties.append({
			name = str("btn_" + self.get_child(x).name),
			type = TYPE_OBJECT
		})
		x = x+1
	return properties
	







#func _get(property):
#	# Convert it to the enum by substringing the value out (see above name)
#	var propertySplitValue = property.substr(property.find("_") + 1)
#	# Since enums are dictionaries, we can just check if it exists through this way
#	if (eTileStates.has(propertySplitValue)):
#		# If it exists, then grab the actual enum value (which is an int)
#		var enumValue = eTileStates[propertySplitValue]
#		# And then return the dictionary value
#		return TileOutlineColours[enumValue]

func _set(properties:String, value):
	print(properties, value)
#	# Convert it to the enum
#	var propertySplitValue = property.substr(property.find("_") + 1)
#	if (eTileStates.has(propertySplitValue)):
#		var enumValue = eTileStates[propertySplitValue]
#		TileOutlineColours[enumValue] = value
#		# Remember to call this
#		property_list_changed_notify()
#		return true
#	return false
