class_name MushroomVoicelineArea
extends VoicelineArea

@export var mushroom : MushroomInteractable

func _process(_delta):
	if not is_instance_valid(current_voiceplayer):
		return
	_play_voiceline(current_voiceplayer)

func _play_voiceline(voice_player):
	if _once:
		if not is_instance_valid(mushroom):
			voice_player.request_voiceline(voiceline, voice_priority)
			_once = false
