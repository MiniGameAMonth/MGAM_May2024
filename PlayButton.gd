extends Take_focus

func _ready():
	grab_focus()
	visibility_changed.connect(get_focus)
