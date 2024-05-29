class_name FootstepArea3D
extends Area3D

@export var footstep_type : FootstepsPlayer3D.FootstepType
var footsteps_entered : Array[Dictionary]

func _ready():
	footsteps_entered = []
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)

func on_area_entered(area):
	print("Area entered ", area, " ", area.get_parent())
	var parent = area.get_parent()
	if parent is FootstepsPlayer3D:
		print("Adding footstep")
		add_footstep(parent)

func on_area_exited(area):
	var parent = area.get_parent()
	if parent is FootstepsPlayer3D:
		remove_footstep(parent)


func add_footstep(footstep):
	var footstep_dict = {
		"footstep_node": footstep,
		"previous_override": footstep.footstep_override
	}
	footsteps_entered.append(footstep_dict)
	footstep.set_override(footstep_type)

func remove_footstep(footstep):
	for i in range(footsteps_entered.size()):
		if footsteps_entered[i]["footstep_node"] == footstep:
			footstep.set_override(footsteps_entered[i]["previous_override"])
			footsteps_entered.remove_at(i)
			break
