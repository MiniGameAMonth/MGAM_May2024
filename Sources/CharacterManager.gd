class_name CharacterManager
extends Node3D

@export var characterStats : CharacterStats

func _ready():
    if characterStats == null:
        print("CharacterStats not set in Inspector")

func take_damage(damage : float):
    characterStats.health -= damage

func use_mana(mana : float):
    characterStats.mana -= mana
