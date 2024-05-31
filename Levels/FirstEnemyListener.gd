extends Node

var first_enemy_died = false
@export var first_enemy_died_voiceline : VoicelineDialogue
@export var voiceline_priority : int

func _ready():
	GlobalEvents.enemy_died.connect(_on_enemy_died)


func _on_enemy_died(_enemy):
	if not first_enemy_died:
		var player = get_tree().get_first_node_in_group(GroupNames.Players)
		var player_a = player.get_node("VoicelinePlayer")
		var player_b = get_tree().get_first_node_in_group(GroupNames.Cat).get_node("VoicelinePlayer")
		first_enemy_died_voiceline.play_dialogue(player_a, player_b)
		first_enemy_died = true
