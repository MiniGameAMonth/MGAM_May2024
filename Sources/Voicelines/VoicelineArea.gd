
class_name VoicelineArea
extends Area3D

@export var voiceline : AudioStream
@export var voice_priority : int = 0
@export var once : bool = true
var _once : bool = true
var current_voiceplayer: VoicelinePlayer

func _ready():
	_once = once
	body_entered.connect(on_body_entered)

func on_body_entered(body):
	if body is Player:
		print("Player entered voiceline area")
		var voice_player = body.get_node("VoicelinePlayer")
		current_voiceplayer = voice_player
		_play_voiceline(voice_player)

func _play_voiceline(voice_player):
	if _once:
		_once = false
		voice_player.request_voiceline(voiceline, voice_priority)
	else:
		voice_player.request_voiceline(voiceline, voice_priority)

func reset():
	_once = once
