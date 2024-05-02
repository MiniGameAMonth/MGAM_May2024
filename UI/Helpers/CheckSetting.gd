extends ConfigSetting


# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_node(".") as CheckBox
	root.connect("toggled", on_check)

func on_check(toggled):
	#GC.set_config_value(setting_section, setting_name, toggled)
	pass

