class_name GameSFX
extends Node

var poolSize = 10
var pool : Array[AudioStreamPlayer3D] = []
var borrowed : Array[AudioStreamPlayer3D] = []
var defaultPlayer : AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready():
	defaultPlayer = add_player()
	defaultPlayer.area_mask = 1 << 7
	pool.remove_at(0)

	for i in range(poolSize):
		var new_player = add_player()
		copy_player(new_player, defaultPlayer)

func add_player():
	var sfx = AudioStreamPlayer3D.new()
	add_child(sfx)
	pool.append(sfx)
	return sfx

func get_available_player():
	for sfx in pool:
		if not sfx.playing:
			return sfx
	return null

func borrow_player():
	var player = get_available_player()
	if player == null:
		push_warning("No available player to play sound, consider increasing pool size.")
		player = add_player()

	borrowed.append(player)
	pool.remove_at(pool.find(player))

	copy_player(player, defaultPlayer)
	return player

func return_player(player : AudioStreamPlayer3D):
	borrowed.remove_at(borrowed.find(player))
	pool.append(player)

func play_sound(other_player : AudioStreamPlayer3D):
	var player = get_available_player()
	if player == null:
		push_warning("No available player to play sound, consider increasing pool size.")
		player = add_player()
	
	copy_player(player, other_player)
	player.global_position = other_player.global_position

	player.play()
	return player

func copy_player(to : AudioStreamPlayer3D, from : AudioStreamPlayer3D):
	to.stream = from.stream
	to.bus = from.bus
	to.volume_db = from.volume_db
	to.pitch_scale = from.pitch_scale
	to.doppler_tracking = from.doppler_tracking
	to.attenuation_model = from.attenuation_model
	to.unit_size = from.unit_size
	to.max_db = from.max_db
	to.area_mask = from.area_mask

func play_sound_at(sound : AudioStream, position : Vector3, bus : String = "Sounds"):
	var player : AudioStreamPlayer3D = get_available_player()
	if player == null:
		push_warning("No available player to play sound, consider increasing pool size.")
		player = add_player()
	
	copy_player(player, defaultPlayer)
	player.global_position = position
	player.stream = sound
	player.bus = bus

	player.play()
	return player
	

		

	
