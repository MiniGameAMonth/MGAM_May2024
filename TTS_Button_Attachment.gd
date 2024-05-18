extends Node
class_name TTS_Button_Attachment

@export var button: Button
@export var TTS_node: TTS
var TTS_text: String

func _ready():
    TTS_text = button.text
    

    
