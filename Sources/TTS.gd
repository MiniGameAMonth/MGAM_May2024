extends Node
class_name TTS

var voices: Array[Dictionary] = DisplayServer.tts_get_voices()
var voice: String = ""

@export var voice_volume: int

func _ready():
	#If Zira voice package is installed, use it
	for v in voices:
		if v["id"] == "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\Voices\\Tokens\\TTS_MS_EN-US_ZIRA_11.0":
			voice = v["id"]
			break
	
	if voice == "":
		printerr("TexToScreen Voice: TTS_MS_EN-US_ZIRA_11.0 not found")

func say_phrase(text: String):		
	DisplayServer.tts_speak(text, voice, voice_volume)