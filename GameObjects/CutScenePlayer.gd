extends Control

##Path to the movie mode video. It's played by default.
@export var path_to_movie_video: String
##Path to the book mode video. It's played when the mode is switched.
@export var path_to_book_video: String
##Path to the level to load after the video is finished.
@export var level_to_load_path: String

var video_player: VideoStreamPlayer
@onready var skip_button: Button = $SkipButton
@onready var mode_switch: CheckBox = $ModeSwitch

func _ready():    
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

    skip_button.pressed.connect(on_skip_button_pressed)
    mode_switch.pressed.connect(on_mode_switch_toggled)

    video_player = get_node("VideoStreamPlayer")
    video_player.finished.connect(on_video_finished)

    var video_stream = VideoStreamTheora.new()
    video_stream.file = path_to_movie_video
    video_player.stream = video_stream
    video_player.play()   

func on_video_finished():
    if level_to_load_path != "":
        Main.load_level(level_to_load_path)    

func on_skip_button_pressed():
    video_player.stop()
    on_video_finished()

func on_mode_switch_toggled():
    if !mode_switch.pressed:
        video_player.stop()
        
        var video_stream = VideoStreamTheora.new()
        video_stream.file = path_to_book_video
        video_player.stream = video_stream
    else:
        video_player.stop()
        
        var video_stream = VideoStreamTheora.new()
        video_stream.file = path_to_movie_video
        video_player.stream = video_stream