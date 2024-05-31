class_name CheckboxControlConfig
extends SaveControlConfig

func _ready():
	super._ready()
	var parent : BaseButton = get_parent()
	parent.toggled.connect(_on_toggled)


func loaded_value(_value):
	call_deferred("update_value")
	GC.save_config()

func _on_toggled(toggled):
	set_value(toggled)

func update_value():
	var parent : BaseButton = get_parent()
	parent.button_pressed = value
	parent.toggled.emit(value)
