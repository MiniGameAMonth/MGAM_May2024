class_name Behaviour
extends Node

@export var behaviour_owner : Node = null
@export var debug_states : bool = false
var last_state : BehaviourState = null
var current_state : BehaviourState = null

func _ready():
	if behaviour_owner == null:
		behaviour_owner = get_parent()

func _process(delta):
	if current_state != null:
		current_state.update(delta)

func _input(event):
	if current_state != null:
		current_state.input(event)

func change_state(state : BehaviourState):
	last_state = current_state
	if last_state != null:
		last_state.exit()
		if debug_states:
			print("Exited state: " + last_state.state_name)
			
	current_state = state
	current_state.enter()
	if current_state != null and debug_states:
		print("Entered state: " + current_state.state_name)
