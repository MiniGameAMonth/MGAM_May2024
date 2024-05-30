class_name CatWaitForPlayerState
extends BehaviourState

var lineOfSight : LineOfSight3D
var follower : Follower
var use_distance : bool
var use_line_of_sight : bool
var player : Node3D
var cat_behaviour : CatBehaviour

const distance_ratio = 0.8

func _init(_behaviour : Behaviour,useDistance:bool = false, useLineOfSight : bool = true):
	super._init(_behaviour)
	self.state_name = "WaitForPlayer"
	use_distance = useDistance
	use_line_of_sight = useLineOfSight
	cat_behaviour = behaviour as CatBehaviour

func enter():
	follower = behaviour.behaviour_owner.get_node("Follower")
	follower.stop()

	player = behaviour.get_tree().get_first_node_in_group(GroupNames.Player)

	lineOfSight = behaviour.behaviour_owner.get_node("LineOfSight3D")
	behaviour.waitForPlayerSound.play()

func update(_delta):
	# either the player is in line of sight or we don't care about line of sight
	var is_line_of_sight = lineOfSight.in_sight || not use_line_of_sight

	var distance = behaviour.player_distance()
	# either the player is close enough or we don't care about distance
	var is_close = distance < cat_behaviour.maxDistanceFromPlayer*distance_ratio || not use_distance
	if is_line_of_sight and is_close:
		follower.resume()
		behaviour.change_state(behaviour.last_state)

func exit():
	behaviour.waitForPlayerSound.stop()



