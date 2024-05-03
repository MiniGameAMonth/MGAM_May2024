class_name GameConfig
extends Node

var configFile = ConfigFile.new()

func _ready():
    load_config()
    GameConfig.new()

func save_config():
    configFile.save("user://config.cfg")

func load_config():
    if configFile.load("user://config.cfg") != OK:
        return

func get_config_value(section: String, value_name: String):
    if not configFile.has_section(section):
        return null
    if not configFile.has_section_key(section, value_name):
        return null
    return configFile.get_value(section, value_name, null)

func set_config_value(section: String, value_name: String, value):
    configFile.set_value(section, value_name, value)

