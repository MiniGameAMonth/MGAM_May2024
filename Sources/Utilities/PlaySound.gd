class_name PlaySound3D
extends Node3D

@export var separateFromNode: bool = false
@export var loop: bool = false

@export var player: AudioStreamPlayer3D
@export var sound: AudioStream

var tempPlayer: AudioStreamPlayer3D

func play():
	if player:
		if separateFromNode:
			tempPlayer = GameSfx.play_sound(player)
		else:
			tempPlayer = player
			player.play()
	else:
		if sound:
			tempPlayer = GameSfx.play_sound_at(sound, global_position)

	tempPlayer.autoplay = loop

func loop_sound():
	tempPlayer.play()

func stop():
	if tempPlayer:
		tempPlayer.stop()
		tempPlayer.autoplay = false