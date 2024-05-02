class_name ConfigSetting
extends Node

@export var setting_section: String = "Configuration";
@export var setting_name: String;

var menu;

# Called when the node enters the scene tree for the first time.
func _ready():
	menu = get_node(".") as MenuButton;
	print(menu)
	if menu.get_popup().item_count == 0:
		return

	var setting_value = "autload stuff" #GC.get_config_value(setting_section, setting_name)
	if setting_value != null:
		menu.text = setting_value
	else:
		menu.text = menu.get_popup().get_item_text(0); 
	
	menu.get_popup().connect("index_pressed", on_change)


func on_change(index):
	if(index != -1):
		menu.text = menu.get_popup().get_item_text(index)
		#GC.set_config_value(setting_section, setting_name, text)

