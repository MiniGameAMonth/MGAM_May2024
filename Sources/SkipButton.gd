extends Button

@export var parentNode : Control

func _ready():
    parentNode.take_focus.connect(on_take_focus)

func on_take_focus():
    grab_focus()
