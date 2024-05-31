extends Node

signal interacted_with(who, what : Interactable)
signal collected_all_mushrooms()
signal enemy_died(enemy : EnemyBehaviour)
signal player_stopped_petting()
signal cat_changed_state(state : BehaviourState)

