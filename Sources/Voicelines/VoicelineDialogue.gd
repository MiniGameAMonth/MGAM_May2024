class_name VoicelineDialogue
extends Resource

@export var voicelines : Array[AudioStream]
@export var different_speakers : bool = true

func play_dialogue(a: VoicelinePlayer, b: VoicelinePlayer = null):
	for i in range(voicelines.size()):
		var line = voicelines[i]
		if i % 2 == 0:
			a.play_voiceline(line)
			await a.finished
		else:
			b.play_voiceline(line)
			await b.finished


