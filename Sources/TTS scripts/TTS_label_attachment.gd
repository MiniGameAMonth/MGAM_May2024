extends Node
class_name  TTS_label_attachment
##UI attachment. Use to add TTS to a label or a rich text label UI element (Used only from gameplay tts)

##Label that needs to be read by TTS
@export var label: Label

##The player hud containing the label
@export var hud: PlayerHUD

func _ready():
	hud.on_label_changed.connect(read_label)

func read_label(new_text: String):	
	TTS.say_phrase(new_text)