class_name PlayerVoicelines
extends Node3D

@export var voiceline_player: VoicelinePlayer

@export var good_kitten_voiceline : AudioStream
@export var ask_guide_star : AudioStream
@export var come_back_star : AudioStream
@export var player : Player
var first_heal : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalEvents.player_stopped_petting.connect(_on_player_stopped_petting)
	player.ask_guide_star.connect(guide_star)


func guide_star():
	var cat = get_tree().get_first_node_in_group(GroupNames.Cat).get_node("Cat Behaviour")
	if cat.current_state is CatIdleState:
		voiceline_player.request_voiceline(ask_guide_star, 1)
	else:
		voiceline_player.request_voiceline(come_back_star, 1)

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
