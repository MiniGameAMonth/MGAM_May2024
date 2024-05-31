class_name PlaySound3D
extends Node3D

signal finished()

@export var separateFromNode: bool = false
@export var stopAfterFinished: bool = false
@export var loop: bool = false
@export var loop_delay: float = 0
@export_range(-60, 10) var volume_db: float = 0

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

func _process(_delta):
	if is_instance_valid(tempPlayer):
		if tempPlayer.playing:
			tempPlayer.global_position = global_transform.origin

func set_stream(stream: AudioStream):
	if player:
		player.stream = stream
	sound = stream

	if tempPlayer:
		tempPlayer.stream = stream

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

	tempPlayer.volume_db = volume_db
	tempPlayer.global_position = global_transform.origin
	tempPlayer.play()
	stopped = false

	if loop:
		if not tempPlayer.finished.is_connected(loop_sound):
			tempPlayer.finished.connect(loop_sound)

	if not tempPlayer.finished.is_connected(_audio_finished):
		tempPlayer.finished.connect(_audio_finished)

func _audio_finished():
	finished.emit()

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
				if not tempPlayer.finished.is_connected(_int_stop_after_finished):
					tempPlayer.finished.connect(_int_stop_after_finished)
					return

		_int_stop_after_finished()
		#tempPlayer.stop()
		#tempPlayer.autoplay = false
		#if tempPlayer.finished.is_connected(loop_sound):
		#	tempPlayer.finished.disconnect(loop_sound)

		#if tempPlayer != player:
		#	GameSfx.return_player(tempPlayer)

		#tempPlayer = null

func _exit_tree():
	if tempPlayer != player:
		GameSfx.return_player(tempPlayer)

func _int_stop_after_finished():
	if tempPlayer == null:
		return
	
	if tempPlayer.finished.is_connected(_int_stop_after_finished):
		tempPlayer.finished.disconnect(_int_stop_after_finished)
	if tempPlayer.finished.is_connected(_audio_finished):
		tempPlayer.finished.disconnect(_audio_finished)

	tempPlayer.stop()
	tempPlayer.autoplay = false
	if tempPlayer.finished.is_connected(loop_sound):
		tempPlayer.finished.disconnect(loop_sound)

	if tempPlayer != player:
		GameSfx.return_player(tempPlayer)
	tempPlayer = null

func is_playing():
	if is_instance_valid(tempPlayer):
		return tempPlayer.playing
	return false
