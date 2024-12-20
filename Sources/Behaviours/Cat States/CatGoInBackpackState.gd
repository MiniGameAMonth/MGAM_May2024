class_name CatGoInBackpackState
extends BehaviourState

var cat_behaviour : CatBehaviour

var in_backpack : bool = false
var player : Node3D

func _init(_behaviour : Behaviour):
	self.behaviour = _behaviour
	self.state_name = "Backpack"

func enter():
	cat_behaviour = behaviour as CatBehaviour
	player = behaviour.get_tree().get_first_node_in_group(GroupNames.Players)
	cat_behaviour.cat.follow(player)

	cat_behaviour.scaredCatSound.play()

	cat_behaviour.interactionArea.disable()
	cat_behaviour.graphics.play("walk")

func update(_delta):
	cat_behaviour.cat.follow(player)
	if cat_behaviour.cat.is_at_target() and not in_backpack:
		cat_behaviour.graphics.visible = false
		cat_behaviour.interactionArea.disable()
		cat_behaviour.backpackSound.play()
		in_backpack = true
	
	if in_backpack:
		cat_behaviour.graphics.visible = false
		cat_behaviour.interactionArea.disable()
		behaviour.behaviour_owner.global_position = player.global_position + Vector3(0, 0, 0.5)

	if not check_enemies():
		behaviour.change_state(CatIdleState.new(behaviour)) # or CatIdleState

func exit():
	if in_backpack:
		cat_behaviour.backpackSound.play()
	
	in_backpack = false
	cat_behaviour.graphics.visible = true
	cat_behaviour.interactionArea.enable()
	cat_behaviour.graphics.play("idle")

func check_enemies():
	for body in cat_behaviour.enemyBackpackSight.sighted_bodies:
		if body.is_in_group(GroupNames.Enemies):
			return true
	return false
