extends Node

var level = null


func _ready():
	scale_window() # Remove this before exporting the game for the web
	load_level("res://Levels/TestLevel.tscn")


func _process(delta):
	pass


func scale_window():
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()

	while window_size.x * 2 < screen_size.x and window_size.y * 2 < screen_size.y:
		window_size.x *= 2
		window_size.y *= 2
	
	DisplayServer.window_set_size(window_size)
	center_window()


func load_level(path):
	level = load(path).instantiate()
	add_child(level)


func center_window():
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()
	DisplayServer.window_set_position((screen_size / 2) - (window_size / 2))
