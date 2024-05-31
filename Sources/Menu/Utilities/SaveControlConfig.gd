class_name SaveControlConfig
extends Node

@export_enum("Config", "Controls", "Volume") var section : String
@export var config_name : String
var value

# Called when the node enters the scene tree for the first time.
func _ready():
	if GC.has_config_value(section, config_name):
		value = GC.get_config_value(section, config_name)
		loaded_value(value)

func load_value(_value):
	self.value = _value
	loaded_value(_value)

func loaded_value(_value):
	pass

func set_value(_value):
	self.value = _value
	GC.set_config_value(section, config_name, _value)
