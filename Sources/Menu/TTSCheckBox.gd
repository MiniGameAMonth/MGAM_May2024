extends CheckBox

func _ready():    
    pressed.connect(on_toggle)

func on_toggle():    
    TTS.toggle_TTS()