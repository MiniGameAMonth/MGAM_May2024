extends CheckBox

func _ready():    
    toggled.connect(on_toggle)

func on_toggle(is_toggled):
    TTS.disabled = not is_toggled