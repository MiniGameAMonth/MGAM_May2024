class_name Sight
extends Area3D

signal sighted(body : Node3D)
signal lost_sight(body : Node3D)

func _ready():
	body_entered.connect(on_sighted)
	body_exited.connect(on_lost_sight)

func on_sighted(body : Node3D) -> void:
	emit_signal("sighted", body)

func on_lost_sight(body : Node3D) -> void:
	emit_signal("lost_sight", body)
