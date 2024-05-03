extends Node

@onready var playButton = $VBoxContainer/Button
@onready var settingsButton = $VBoxContainer/Button2

@export var playLevel : String;
@export var settingsLevel : String;


# Called when the node enters the scene tree for the first time.
func _ready():
	playButton.connect("pressed", on_play)
	settingsButton.connect("pressed", on_settings)


func on_play():
	Main.change_level(playLevel)

func on_settings():
	Main.change_level(settingsLevel)
