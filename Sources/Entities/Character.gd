class_name Character
extends Node3D

@export var characterStats : CharacterStats

signal health_changed(health : int)
signal damaged(damage : int)
signal hurt()
signal mana_changed(mana : int)
signal on_death()

func _ready():
	if characterStats == null:
		print("CharacterStats not set in Inspector")

func take_damage(damage : int):
	damaged.emit(damage)
	hurt.emit()
	characterStats.health -= damage
	health_changed.emit(characterStats.health)

	if characterStats.health <= 0:
		die()

func heal(healh : int):
	characterStats.health += healh
	characterStats.health = min(characterStats.health, characterStats.max_health)
	health_changed.emit(characterStats.health)

func use_mana(mana : int):
	characterStats.mana -= mana

func die():
	on_death.emit()
