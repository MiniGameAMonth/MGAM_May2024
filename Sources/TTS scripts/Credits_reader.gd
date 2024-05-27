extends Node
class_name Credits_reader

##Button that opens the credits menu
@export var credits_button: Button

##Label containing the credit's text
@export var label: RichTextLabel

@export var back_button: Button

var timer = Timer.new() #timer to avoid TTS skipping this phrase (or whole text in this case)

func _ready():
    add_child(timer)    
    credits_button.pressed.connect(on_credit_button_pressed)    
    back_button.pressed.connect(on_back_button_pressed)
    timer.timeout.connect(on_timer_timeout)

func on_credit_button_pressed():    
    timer.start(2)    

func on_timer_timeout():
    timer.stop()
    TTS.say_phrase(label.text)

func on_back_button_pressed():
    timer.stop()
    TTS.stop()