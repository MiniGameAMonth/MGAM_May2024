extends Area3D

# TODO: Wait for certain action
# TODO: Block inputs except needed ones
# TODO: Show for certain amount of time\
# TODO: Block user actions if something need to be done

enum TutorialType {
	UNTIL_SOUND_IS_PLAYING,
	WAIT_FOR_ACTION,
	WAIT_TIME,
	LOOK_AT_OBJECT
}

var tutorialHUD
@export var disabled = false
var tutorial_started = false
var task_completed = false

@export var tutorial_type: TutorialType
@export var block_user_actions: bool = false
@export var action_to_wait_for: String
@export var seconds_to_wait: float = 1
@export var object_to_look_at: Node3D
@export var tutorial_line: String

@export var voice_line: AudioStreamWAV
@export var subtitle: String

@export var voice_line_after_completion: AudioStreamWAV
@export var subtitle_after_completion: String

var prev_tts_is_stopped = true

func _process(delta: float) -> void:
	if Main.tutorials_enabled:
		var prev_task_completed = task_completed

		if tutorial_started && !task_completed:
			if TTS.is_stopped() && TTS.is_stopped() != prev_tts_is_stopped:
				task_completed = true
				_on_audio_player_finished()

		prev_tts_is_stopped = TTS.is_stopped()

		# Wait for player to look at the object
		if !task_completed && tutorial_started && tutorial_type == TutorialType.LOOK_AT_OBJECT:
			if object_to_look_at:
				var player = get_tree().root.get_node("MainRoot/Level/Level/Player")

				if player.is_looking_at(object_to_look_at):
					task_completed = true
					player.block_movement = false
					tutorialHUD.get_node("Panel/MovementDisabled").hide()

		# After all checks if we completed the task - show "after completion" message
		if !prev_task_completed && task_completed:
			if voice_line_after_completion && subtitle_after_completion:
				tutorialHUD.fade_in()
				tutorialHUD.set_subtitle(replace_actions_with_buttons(subtitle_after_completion))
				$IntroTimer.start()


func _ready():
	tutorialHUD = get_tree().root.get_node("MainRoot/UICanvas/TutorialHUD")


func _on_body_entered(body):
	if Main.tutorials_enabled:
		if body.name == "Player" && !disabled:
			disabled = true
			tutorial_started = true
			$IntroTimer.start()
			tutorialHUD.fade_in()
			tutorialHUD.set_subtitle(replace_actions_with_buttons(tutorial_line))
			tutorialHUD.tutorial = self;

			if block_user_actions:
				var level = get_tree().root.get_node("MainRoot/Level").get_child(0)
				var player = level.get_node("Player")
				player.block_movement = true			
				tutorialHUD.get_node("Panel/MovementDisabled").show()
			else:
				tutorialHUD.get_node("Panel/MovementDisabled").hide()


func _on_intro_timer_timeout():
	if Main.tutorials_enabled:
		if !task_completed:
			$AudioPlayer.stream = voice_line
		else:
			$AudioPlayer.stream = voice_line_after_completion
			tutorialHUD.get_node("Panel/MovementDisabled").hide()
		
		TTS.say_phrase(replace_actions_with_buttons(tutorial_line), true)
		# $AudioPlayer.play()

func _exit_tree():
	if Main.tutorials_enabled:
		$AudioPlayer.stop()
		tutorialHUD.fade_out()
		tutorialHUD.tutorial = null


func _on_audio_player_finished():
	if Main.tutorials_enabled:
		tutorialHUD.fade_out()
		tutorialHUD.tutorial = null

		if tutorial_type == TutorialType.UNTIL_SOUND_IS_PLAYING:
			var player = get_tree().root.get_node("MainRoot/Level/Level/Player")
			player.block_movement = false


func tutorial_skip():
	task_completed = true;
	$AudioPlayer.stop()
	_on_audio_player_finished()
	TTS.stop()

func replace_actions_with_buttons(line):
	var regex = RegEx.new()
	regex.compile("\\[([^\\[\\]]+)\\]")
	var results = regex.search_all(line)	

	if results: 
		for i in results.size():
			var action_name = results[i].get_string(1)
			var text = ""
			var input_events = InputMap.action_get_events(action_name)

			for input_event in input_events:
				if text.length() == 0:
					text += input_event.as_text()
				else:
					text += " or " + input_event.as_text()

			line = line.replace("[" + action_name + "]", text)

	return line