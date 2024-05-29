class_name Waypoint3D
extends Node3D

@export var waypoint_group = "Waypoints"

func _ready():
	add_to_group(waypoint_group)

