extends Node

func play_dialogue(dialogue: VoicelineDialogue, a: VoicelinePlayer, b: VoicelinePlayer = null):
	for i in range(dialogue.voicelines.size()):
		var line = dialogue.voicelines[i]
		if i % 2 == 0:
			a.play_voiceline(line)
			await a.finished
		else:
			b.play_voiceline(line)
			await b.finished
