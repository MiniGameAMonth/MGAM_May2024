extends HSlider

func _ready():
    value_changed.connect(on_value_changed)

func on_value_changed(volume):
    TTS.set_voice_volume(volume)