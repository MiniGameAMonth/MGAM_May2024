extends Area3D

var mushrooms_collected: bool = false

func _ready():
    GlobalEvents.collected_all_mushrooms.connect(on_mushrooms_collected) 
    body_entered.connect(on_body_entered)

func on_mushrooms_collected():
    mushrooms_collected = true

func on_body_entered(_body):
    if mushrooms_collected:
        Main.load_level("res://GameObjects/CutScenePlayer_Ending.tscn")
