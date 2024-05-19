extends Node
class_name TTS
##TTS main node. This reads all the texts sent by the UI attachments

var voices: Array[Dictionary] = DisplayServer.tts_get_voices()
var voice: String = ""
var disabled: bool = false

@export var voice_volume: int

func _ready():
	#Checks if Zira voice package is installed
	for v in voices:
		if v["id"] == "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\Voices\\Tokens\\TTS_MS_EN-US_ZIRA_11.0":
			voice = v["id"]
			break
	
	if voice == "":
		printerr("TexToScreen Voice: TTS_MS_EN-US_ZIRA_11.0 not found")

func say_phrase(text: String):
	if !disabled:		
		DisplayServer.tts_stop()		
		DisplayServer.tts_speak(text, voice, voice_volume)	

func disable_TTS():
	pass