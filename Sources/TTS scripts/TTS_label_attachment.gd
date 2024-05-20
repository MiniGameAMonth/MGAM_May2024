extends Node
class_name  TTS_label_attachment
##UI attachment. Use to add TTS to a label or a rich text label UI element

##Label that nneds to be read by TTS
@export var label: Label

##Rich text label that needs to be read by TTS
@export var rich_label: RichTextLabel

##TTS node in this UI
@export var TTS_node: TTS

func _ready():
	if TTS_node == null:
		printerr("TTS node not set")
		return