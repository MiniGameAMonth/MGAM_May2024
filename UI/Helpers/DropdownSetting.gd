class_name DropdownSetting
extends ConfigSetting


@onready var menu = $".";

# Called when the node enters the scene tree for the first time.
func _ready():
	print(menu)
	menu = get_node(".") as MenuButton;
	
	if menu.get_popup().item_count == 0:
		return

	var setting_value = GC.get_config_value(setting_section, setting_name)
	if setting_value != null:
		menu.text = setting_value
	else:
		menu.text = menu.get_popup().get_item_text(0); 
		update_setting(menu.text)
		
	
	menu.get_popup().connect("index_pressed", on_change)


func on_change(index):
	if(index != -1):
		menu.text = menu.get_popup().get_item_text(index)
		update_setting(menu.text)
		
