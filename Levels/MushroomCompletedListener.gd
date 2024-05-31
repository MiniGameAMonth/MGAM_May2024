extends Node

@export var mushrooms_collected_voiceline : VoicelineDialogue
@export var voiceline_priority : int

func _ready():
	GlobalEvents.collected_all_mushrooms.connect(_on_collected_all_mushrooms)

func _on_collected_all_mushrooms():
	var player = get_tree().get_first_node_in_group(GroupNames.Players).get_node("VoicelinePlayer")
	var cat = get_tree().get_first_node_in_group(GroupNames.Cat).get_node("VoicelinePlayer")
	mushrooms_collected_voiceline.play_dialogue(player, cat)
