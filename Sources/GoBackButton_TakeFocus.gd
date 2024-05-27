extends Control

@export var credits_text : RichTextLabel

func _ready():
	credits_text.visibility_changed.connect(on_credits_visible)

func on_credits_visible():
	if credits_text.visible:
		grab_focus()