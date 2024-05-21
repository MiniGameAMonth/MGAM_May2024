class_name GameSFX
extends Node

var poolSize = 10
var pool : Array[AudioStreamPlayer3D] = []
var defaultPlayer : AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready():
	defaultPlayer = add_player()
	remove_child(defaultPlayer)
	defaultPlayer.area_mask = 1 << 8

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

func play_sound(other_player : AudioStreamPlayer3D):
	var player = get_available_player()
	if player == null:
		push_warning("No available player to play sound, consider increasing pool size.")
		player = add_player()
	
	copy_player(player, other_player)

	player.play()

func copy_player(to : AudioStreamPlayer3D, from : AudioStreamPlayer3D):
	from.global_position = to.global_position
	from.stream = to.stream
	from.bus = to.bus
	from.volume_db = to.volume_db
	from.pitch_scale = to.pitch_scale
	from.doppler_tracking = to.doppler_tracking
	from.attenuation_model = to.attenuation_model
	from.unit_size = to.unit_size
	from.max_db = to.max_db
	from.area_mask = to.area_mask

func play_sound_at(sound : AudioStream, position : Vector3, bus : String = "Sounds"):
	var player : AudioStreamPlayer3D = get_available_player()
	if player == null:
		push_warning("No available player to play sound, consider increasing pool size.")
		player = add_player()
	
	copy_player(player, defaultPlayer)
	player.global_position = position
	player.stream = sound

	player.play()
	

		

	
