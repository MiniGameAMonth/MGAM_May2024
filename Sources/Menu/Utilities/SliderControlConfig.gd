class_name SliderControlConfig
extends SaveControlConfig

func _ready():
	super._ready()
	var parent : Range = get_parent()
	parent.value_changed.connect(_value_changed)


func loaded_value(_value):
	call_deferred("update_value")
	GC.save_config()

func _value_changed(new_value):
	set_value(new_value)

func update_value():
	var parent : Range = get_parent()
	parent.value = value
	parent.value_changed.emit(value)
	parent.changed.emit()
