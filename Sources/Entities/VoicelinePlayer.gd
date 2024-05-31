class_name VoicelinePlayer
extends PlaySound3D

var current_voiceline_priority = 0

func request_voiceline(voiceline: AudioStream, priority: int = 0):
	if is_playing():
		if priority > current_voiceline_priority:
			stop()
			play_voiceline(voiceline, priority)
	else:
		play_voiceline(voiceline, priority)
	
func play_voiceline(voiceline: AudioStream, priority: int = 0):
	current_voiceline_priority = priority
	set_stream(voiceline)
	play()