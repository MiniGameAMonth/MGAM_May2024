class_name CatFindExitState
extends BehaviourState

var cat_behaviour : CatBehaviour
var at_target : bool = false
var player : Node3D

func enter():
    cat_behaviour = behaviour as CatBehaviour
    cat_behaviour.graphics.play("walk")
    cat_behaviour.cat.resume()

    player = behaviour.get_tree().get_first_node_in_group(GroupNames.Players)

    var exit_node = behaviour.get_tree().get_first_node_in_group(GroupNames.Exit)
    cat_behaviour.cat.follow(exit_node)

func update(_delta: float):
    if cat_behaviour.cat.is_at_target() and not at_target:
        push_warning("Missing cat found exit sound trigger.")
        cat_behaviour.graphics.play("idle")
        cat_behaviour.cat.stop()
        at_target = true
    
    if behaviour.global_position.distance_to(player.global_position) > cat_behaviour.maxDistanceFromPlayer:
        cat_behaviour.graphics.play("idle")
        cat_behaviour.cat.stop()
        behaviour.change_state(CatWaitForPlayerState.new(behaviour, true, true))