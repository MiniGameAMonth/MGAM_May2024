extends Node

@export var healing_dialogue : VoicelineDialogue
@export var voiceline_priority : int

var enemy_count = 0

func _ready():
	GlobalEvents.enemy_died.connect(_on_enemy_died)

func _on_enemy_died(_enemy):
	enemy_count += 1
	if enemy_count == 2:
		var player = get_tree().get_first_node_in_group(GroupNames.Players).get_node("VoicelinePlayer")
		var cat = get_tree().get_first_node_in_group(GroupNames.Cat).get_node("VoicelinePlayer")
		healing_dialogue.play_dialogue(player, cat)
