class_name GameSFX
extends Node

var poolSize = 10
var pool : Array[AudioStreamPlayer3D] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(poolSize):
		add_player()
	pass # Replace with function body.

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
	
	player.global_position = other_player.global_position
	player.stream = other_player.stream
	player.bus = other_player.bus
	player.volume_db = other_player.volume_db
	player.pitch_scale = other_player.pitch_scale
	player.doppler_tracking = other_player.doppler_tracking
	player.attenuation_model = other_player.attenuation_model
	player.unit_size = other_player.unit_size
	player.max_db = other_player.max_db
	player.area_mask = other_player.area_mask
	#these are the important ones I guess

	player.play()
		

	
