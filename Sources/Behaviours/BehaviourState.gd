class_name BehaviourState
extends Object

var behaviour : Behaviour
var state_name : String = "BehaviourState"

func _init(_behaviour : Behaviour) -> void:
    behaviour = _behaviour
    state_name = "BehaviourState"

func enter() -> void:
    pass

func update(_delta: float) -> BehaviourState:
    return null

func input(_event: InputEvent) -> void:
    pass

func exit() -> void:
    pass