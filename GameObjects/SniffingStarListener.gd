extends Area3D

@export var found_star_voiceline : AudioStream
var player_voiceline : VoicelinePlayer

func _ready():
	body_entered.connect(on_body_entered)
	player_voiceline = get_parent().get_node("VoicelinePlayer")


func on_body_entered(body):
	if body.has_node("Cat Behaviour"):
		var cat_behaviour = body.get_node("Cat Behaviour")
		if cat_behaviour.current_state is CatSniffingState:
			player_voiceline.request_voiceline(found_star_voiceline)
