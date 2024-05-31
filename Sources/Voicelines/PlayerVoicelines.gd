class_name PlayerVoicelines
extends Node3D

@export var voiceline_player: VoicelinePlayer

@export var good_kitten_voiceline : AudioStream
var first_heal : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalEvents.player_stopped_petting.connect(_on_player_stopped_petting)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_stopped_petting():
	if first_heal:
		voiceline_player.request_voiceline(good_kitten_voiceline, 1)
		first_heal = false
	else:
		if not voiceline_player.is_playing():
			var random = randi() % 4
			if random == 0:
				voiceline_player.request_voiceline(good_kitten_voiceline, 1)