class_name Projected2DNode
extends Node2D

@onready var parent : Node3D = get_parent()

const PIXEL_PER_METER = 20

func _ready():
    if parent == null:
        push_error("Parent is null. Projected2DNode must be a child of a Node3D")
        queue_free()

    elif not parent is Node3D:
        push_error("Projected2DNode must be a child of a Node3D")
        queue_free()

func _process(_delta):
    transform.origin.x = parent.global_transform.origin.x * PIXEL_PER_METER
    transform.origin.y = parent.global_transform.origin.z * PIXEL_PER_METER