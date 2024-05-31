class_name VoicelinePlayer
extends PlaySound3D

var current_voiceline_priority = 0

func _ready():
	pass

func _process(_delta):
	pass

func request_voiceline(voiceline: AudioStream, priority: int):
	if is_playing():
		if priority > current_voiceline_priority:
			stop()
			play_voiceline(voiceline, priority)
	else:
		play_voiceline(voiceline, priority)
	
func play_voiceline(voiceline: AudioStream, priority: int):
	current_voiceline_priority = priority
	set_stream(voiceline)
	play()