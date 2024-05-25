class_name PlaySound3D
extends Node3D

@export var separateFromNode: bool = false
@export var loop: bool = false
@export var loop_delay: float = 0

@export var player: AudioStreamPlayer3D
@export var sound: AudioStream

var tempPlayer: AudioStreamPlayer3D
var timer

func _ready():
	if loop_delay > 0:
		timer = Timer.new()
		timer.set_wait_time(loop_delay)
		timer.set_one_shot(true)
		timer.timeout.connect(_int_loop_sound)
		add_child(timer)

func play():
	if player:
		if separateFromNode:
			tempPlayer = GameSfx.borrow_player()
			GameSfx.copy_player(tempPlayer, player)
		else:
			tempPlayer = player
	else:
		if sound:
			tempPlayer = GameSfx.borrow_player()
			GameSfx.copy_player(tempPlayer, player)
			tempPlayer.stream = sound

	tempPlayer.play()
	tempPlayer.global_position = global_transform.origin

	if loop:
		tempPlayer.finished.connect(loop_sound)

func loop_sound():
	if loop_delay > 0:
		timer.start()
	else:
		_int_loop_sound()

func _int_loop_sound():
	tempPlayer.play()

func stop():
	if tempPlayer:
		tempPlayer.stop()
		tempPlayer.autoplay = false
		tempPlayer.finished.disconnect(loop_sound)

		if tempPlayer != player:
			GameSfx.return_player(tempPlayer)