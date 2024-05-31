
class_name VoicelineDialogueArea
extends Area3D

@export var dialogue : VoicelineDialogue
@export var voice_priority : int = 0
@export var once : bool = true
var _once : bool = true
var current_voiceplayer_a: VoicelinePlayer
var current_voiceplayer_b: VoicelinePlayer

func _ready():
	_once = once
	body_entered.connect(on_body_entered)

func on_body_entered(body):
	if body is Player:
		var voice_player = body.get_node("VoicelinePlayer")
		current_voiceplayer_a = voice_player
		current_voiceplayer_b = get_tree().get_first_node_in_group(GroupNames.Cat).get_node("VoicelinePlayer")
		_play_voiceline(voice_player)

func _play_voiceline(_voice_player):
	if once:
		if _once:
			_once = false
			play_dialogue(dialogue, current_voiceplayer_a, current_voiceplayer_b)
	else:
		play_dialogue(dialogue, current_voiceplayer_a, current_voiceplayer_b)

func reset():
	_once = once

func play_dialogue(_dialogue: VoicelineDialogue, a: VoicelinePlayer, b: VoicelinePlayer = null):
	for i in range(_dialogue.voicelines.size()):
		var line = _dialogue.voicelines[i]
		if i % 2 == 0:
			a.play_voiceline(line, voice_priority)
			await a.finished
		else:
			b.play_voiceline(line, voice_priority)
			await b.finished
