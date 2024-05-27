class_name CatWaitForPlayerState
extends BehaviourState

var lineOfSight : LineOfSight3D
var follower : Follower

func _init(_behaviour : Behaviour):
	super._init(_behaviour)
	self.state_name = "WaitForPlayer"

func enter():
	follower = behaviour.behaviour_owner.get_node("Follower")
	follower.stop()

	lineOfSight = behaviour.behaviour_owner.get_node("LineOfSight3D")
	behaviour.waitForPlayerSound.play()

func update(_delta):
	if lineOfSight.in_sight:
		follower.resume()
		behaviour.change_state(behaviour.last_state)

func exit():
	behaviour.waitForPlayerSound.stop()



