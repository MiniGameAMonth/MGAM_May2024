class_name InputConfig

var name : String
var config_path : String
var config : ConfigFile = ConfigFile.new()


func _init(config_path : String):
    self.config_path = config_path
    config.load(config_path)
    name = config.get_value("INFO", "Scheme name", "OH MY GOD IT'S NOT SET YET")