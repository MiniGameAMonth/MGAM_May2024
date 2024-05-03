class_name ConfigSetting
extends Node

@export var setting_section: String = "Configuration";
@export var setting_name: String;

func update_setting(new_value):
	GC.set_config_value(setting_section, setting_name, new_value)
