class_name Character
extends Node3D

@export var characterStats : CharacterStats

signal health_changed(health : int)
signal damaged(damage : int)
signal hurt()
signal mana_changed(mana : int)
signal on_death()
signal healed()

func take_damage(damage : int):
	if characterStats.health <= 0:
		return
	damaged.emit(damage)
	hurt.emit()
	characterStats.health = clamp(characterStats.health - damage, 0, characterStats.max_health)
	health_changed.emit(characterStats.health)

	if characterStats.health <= 0:
		die()

func heal(healh : int):
	var prev_health = characterStats.health
	characterStats.health += healh
	characterStats.health = min(characterStats.health, characterStats.max_health)
	health_changed.emit(characterStats.health)

	if prev_health != characterStats.health:
		healed.emit()
	
	if characterStats.health == characterStats.max_health:
		TTS.say_phrase("Full health")	


func use_mana(mana : int):
	characterStats.mana -= mana

func die():
	on_death.emit()
