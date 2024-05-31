class_name FootstepsPlayer3D
extends PlaySound3D

enum FootstepType { None, Stone, Grass, Water }

@export var character : CharacterBody3D

@export var footstep_type : FootstepType = FootstepType.Stone
@export var footstep_override : FootstepType = FootstepType.None

var playing : bool = false
var enabled : bool = true

func _process(_delta):
	if not enabled:
		return

	if abs(character.velocity.x) + abs(character.velocity.z) > 0.1:
		if not playing:
			playing = true
			play()
	else:
		if playing:
			playing = false
			stop()

func set_override(override : FootstepType):
	footstep_override = override
	if footstep_type != footstep_override:
		disable()
	else:
		enable()

func disable():
	enabled = false
	playing = false
	stop()

func enable():
	enabled = true
