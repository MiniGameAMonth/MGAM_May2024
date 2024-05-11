class_name InputConfig

var name : String
var configPath : String
var config : ConfigFile = ConfigFile.new()


func _init(configPath : String):
    self.configPath = configPath
    config.load(configPath)
    name = config.get_value("INFO", "Scheme name", "OH MY GOD IT'S NOT SET YET")