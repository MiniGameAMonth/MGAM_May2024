extends Control

##Path to the movie mode video. It's played by default.
@export var path_to_movie_video: String
##Path to the book mode video. It's played when the mode is switched.
@export var path_to_book_video: String
##Path to the level to load after the video is finished.
@export var level_to_load_path: String
##Check if game's ending
@export var is_ending: bool

var video_player: VideoStreamPlayer
@onready var skip_button: Button = $Container/SkipButton
@onready var mode_switch: CheckBox = $Container/ModeSwitch
@onready var panel : Panel = $Panel
@onready var label : Label = $Label

signal take_focus

var warning_duration_timer: Timer
var start_warning_timer: Timer

func _ready():	    
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	skip_button.pressed.connect(on_skip_button_pressed)
	mode_switch.toggled.connect(on_mode_switch_toggled)
	panel.gui_input.connect(on_input)

	video_player = get_node("VideoStreamPlayer")
	video_player.finished.connect(on_video_finished)

	if is_ending:
		var video_stream = VideoStreamTheora.new()
		video_stream.file = path_to_movie_video
		video_player.stream = video_stream
		video_player.play()
		return
	
	mode_switch.disabled = true

	start_warning_timer = Timer.new()
	add_child(start_warning_timer)
	start_warning_timer.timeout.connect(on_start_warning_timer_timeout)
	start_warning_timer.start(1)

	warning_duration_timer = Timer.new()
	add_child(warning_duration_timer)
	warning_duration_timer.timeout.connect(on_warning_duration_timer_timeout)

func on_video_finished():
	if level_to_load_path != "":
		Main.load_level(level_to_load_path)    

func on_skip_button_pressed():
	video_player.stop()
	on_video_finished()

func on_mode_switch_toggled(toggle: bool):
	if !toggle:
		video_player.stop()
		
		var video_stream = VideoStreamTheora.new()
		video_stream.file = path_to_book_video
		video_player.stream = video_stream
		video_player.play()
	else:
		video_player.stop()
		
		var video_stream = VideoStreamTheora.new()
		video_stream.file = path_to_movie_video
		video_player.stream = video_stream
		video_player.play()

func on_warning_duration_timer_timeout():
	emit_signal("take_focus")
	warning_duration_timer.stop()

	var warning_image : TextureRect = $TextureRect
	warning_image.visible = false
	panel.visible = false
	label.visible = false
	
	mode_switch.disabled = false

	video_player = get_node("VideoStreamPlayer")
	video_player.finished.connect(on_video_finished)

	var video_stream = VideoStreamTheora.new()
	video_stream.file = path_to_movie_video
	video_player.stream = video_stream
	video_player.play()

func on_input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		TTS.stop()
		warning_duration_timer.stop()
		start_warning_timer.stop()
		warning_duration_timer.emit_signal("timeout")
		emit_signal("take_focus")
		panel.visible = false
		label.visible = false

func on_start_warning_timer_timeout():
	start_warning_timer.stop()
	warning_duration_timer.start(20)

	TTS.stop()
	TTS.say_phrase("Click anywhere to skip warning.
	The following cutscene uses patterns that may induce seizures in people who have photosensitive epilepsy.
	Immediatly stop playing and consult a doctor if you experience any symptoms.
	For a safer experience: Skip the cutscene or toggle it from movie mode to book mode.") 