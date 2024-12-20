extends Node
class_name TTS
##TTS main node. This reads all the texts sent by the UI attachments

var voices = DisplayServer.tts_get_voices_for_language("en")
static var voice_id
static var disabled: bool = false
static  var voice_volume: int = 80

func _ready():	
	voice_id = voices[0]
	
	if voice_id == null:
		printerr("No tex-to-screen voice found")

static func say_phrase(text: String, prioritize : bool = false):
	if !disabled:		
		if prioritize:
			DisplayServer.tts_stop()
			DisplayServer.tts_speak(text, voice_id, voice_volume, true)	
		else:
			if !DisplayServer.tts_is_speaking():
				DisplayServer.tts_speak(text, voice_id, voice_volume, true)	

static func toggle_TTS(is_enabled : int = 0):
	if is_enabled == 0:
		if disabled:
			disabled = false
			say_phrase("Text-to-speech: on")
		else:
			disabled = true
	if is_enabled == 1:
		disabled = false
	if is_enabled == 2:
		disabled = true

static func set_voice_volume(volume: int):
	voice_volume = volume

static func get_voice_volume():
	return voice_volume

static func stop():
	DisplayServer.tts_stop()

static func is_stopped():
	return !DisplayServer.tts_is_speaking()
