extends Node3D

@export var enemyHealth : float

func takeDamage(damage : float) -> void:
    enemyHealth -= damage
    if enemyHealth <= 0:
        queue_free()
