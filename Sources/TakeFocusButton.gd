extends Control
class_name Take_focus
#The object with this script will take focus when it becomes visible, required for keyboard navigation

func _ready():
    visibility_changed.connect(get_focus)    

func get_focus():    
    if visible:
        grab_focus()