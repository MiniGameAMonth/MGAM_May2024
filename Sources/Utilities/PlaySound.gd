class_name PlaySound3D
extends Node3D

@export var separateFromNode: bool = false
@export var stopAfterFinished: bool = false
@export var loop: bool = false
@export var loop_delay: float = 0

@export var player: AudioStreamPlayer3D
@export var sound: AudioStream
@export_enum("Master", "Interface", "Sounds", "Speech") var audio_bus: String = "Master"

var tempPlayer: AudioStreamPlayer3D
var timer
var stopped: bool = false

func _ready():
	if loop_delay > 0:
		timer = Timer.new()
		timer.set_wait_time(loop_delay)
		timer.set_one_shot(true)
		timer.timeout.connect(_int_loop_sound)
		add_child(timer)

func play():
	if tempPlayer == null:
		if player:
			if separateFromNode:
				tempPlayer = GameSfx.borrow_player()
				GameSfx.copy_player(tempPlayer, player)
			else:
				tempPlayer = player
		else:
			if sound:
				tempPlayer = GameSfx.borrow_player()
				tempPlayer.stream = sound
				tempPlayer.bus = audio_bus

	if tempPlayer == null:
		return

	tempPlayer.global_position = global_transform.origin
	tempPlayer.play()
	stopped = false

	if loop:
		if not tempPlayer.finished.is_connected(loop_sound):
			tempPlayer.finished.connect(loop_sound)

func loop_sound():
	if loop_delay > 0:
		timer.start()
	else:
		_int_loop_sound()

func _int_loop_sound():
	if not stopped:
		if tempPlayer:
			tempPlayer.global_position = global_transform.origin
			tempPlayer.play()

func stop():
	stopped = true
	if tempPlayer:
		if tempPlayer.playing:
			if stopAfterFinished:
				tempPlayer.finished.connect(_int_stop_after_finished)
				return

		tempPlayer.stop()
		tempPlayer.autoplay = false
		if tempPlayer.finished.is_connected(loop_sound):
			tempPlayer.finished.disconnect(loop_sound)

		if tempPlayer != player:
			GameSfx.return_player(tempPlayer)

		tempPlayer = null

func _exit_tree():
	if tempPlayer != player:
		GameSfx.return_player(tempPlayer)

func _int_stop_after_finished():
	if tempPlayer == null:
		return
	
	if tempPlayer.finished.is_connected(_int_stop_after_finished):
		tempPlayer.finished.disconnect(_int_stop_after_finished)

	tempPlayer.stop()
	tempPlayer.autoplay = false
	if tempPlayer.finished.is_connected(loop_sound):
		tempPlayer.finished.disconnect(loop_sound)

	if tempPlayer != player:
		GameSfx.return_player(tempPlayer)
	tempPlayer = null
