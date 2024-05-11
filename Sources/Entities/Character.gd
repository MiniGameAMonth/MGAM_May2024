class_name Character
extends Node3D

@export var characterStats : CharacterStats

signal health_changed(health : float)
signal mana_changed(mana : float)
signal on_death()

func _ready():
    if characterStats == null:
        print("CharacterStats not set in Inspector")

func take_damage(damage : float):
    characterStats.health -= damage
    emit_signal("health_changed", characterStats.health)

    if characterStats.health <= 0:
        die()

func use_mana(mana : float):
    characterStats.mana -= mana

func die():
    emit_signal("on_death")