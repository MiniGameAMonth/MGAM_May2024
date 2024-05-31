class_name VoicelineDialogue
extends Resource

@export var voicelines : Array[AudioStream]
@export var different_speakers : bool = true
@export var dialogue_priority : int = 0

func play_dialogue(a: VoicelinePlayer, b: VoicelinePlayer = null):
	for i in range(voicelines.size()):
		var line = voicelines[i]
		if i % 2 == 0:
			if line == null:
				await a.get_tree().create_timer(1.0).timeout
			else: 
				a.request_voiceline(line, dialogue_priority)
				await a.finished
		else:
			if line == null:
				await b.get_tree().create_timer(1.0).timeout
			else:
				b.request_voiceline(line, dialogue_priority)
				await b.finished


