class_name GameConfig
extends Node

var configFile = ConfigFile.new()

func _ready():
    load_config()

func save_config():
    configFile.save("user://config.cfg")

func load_config():
    if configFile.load("user://config.cfg") != OK:
        return

func get_config_value(section: String, value_name: String, default_value = null):
    if not configFile.has_section(section):
        return default_value
    if not configFile.has_section_key(section, value_name):
        return default_value
    return configFile.get_value(section, value_name, default_value)

func has_config_value(section: String, value_name: String):
    if not configFile.has_section(section):
        return false
    if not configFile.has_section_key(section, value_name):
        return false
    return true

func set_config_value(section: String, value_name: String, value):
    configFile.set_value(section, value_name, value)

func _exit_tree():
    save_config()

