
class_name VoicelineArea
extends Area3D

signal voiceline_finished

@export var voiceline : AudioStream
@export var voice_priority : int = 0
@export var once : bool = true
var _once : bool = true
var current_voiceplayer: VoicelinePlayer

func _ready():
	_once = once
	body_entered.connect(on_body_entered)

func trigger_finished():
	voiceline_finished.emit()

func on_body_entered(body):
	if body is Player:
		var voice_player = body.get_node("VoicelinePlayer")
		if current_voiceplayer != null:
			current_voiceplayer.finished.disconnect(trigger_finished)
		current_voiceplayer = voice_player
		current_voiceplayer.finished.connect(trigger_finished)
		_play_voiceline(voice_player)

func _exit_tree():
	if current_voiceplayer != null:
		current_voiceplayer.finished.disconnect(trigger_finished)

func _play_voiceline(voice_player):
	if once:
		if _once:
			_once = false
			voice_player.request_voiceline(voiceline, voice_priority)
	else:
		voice_player.request_voiceline(voiceline, voice_priority)

func reset():
	_once = once
