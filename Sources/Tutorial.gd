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

@export var voice_line: AudioStreamWAV
@export var subtitle: String

@export var voice_line_after_completion: AudioStreamWAV
@export var subtitle_after_completion: String


func _process(delta: float) -> void:
	var prev_task_completed = task_completed

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
			tutorialHUD.set_subtitle(subtitle_after_completion)
			$IntroTimer.start()


func _ready():
	tutorialHUD = get_tree().root.get_node("MainRoot/UICanvas/TutorialHUD")


func _on_body_entered(body):
	if body.name == "Player" && !disabled:
		disabled = true
		tutorial_started = true
		$IntroTimer.start()
		tutorialHUD.fade_in()
		tutorialHUD.set_subtitle(subtitle)

		if block_user_actions:
			var level = get_tree().root.get_node("MainRoot/Level").get_child(0)
			var player = level.get_node("Player")
			player.block_movement = true			
			tutorialHUD.get_node("Panel/MovementDisabled").show()
		else:
			tutorialHUD.get_node("Panel/MovementDisabled").hide()


func _on_intro_timer_timeout():
	if !task_completed:
		$AudioPlayer.stream = voice_line
	else:
		$AudioPlayer.stream = voice_line_after_completion
		tutorialHUD.get_node("Panel/MovementDisabled").hide()

	$AudioPlayer.play()


func _on_audio_player_finished():
	tutorialHUD.fade_out()

	if tutorial_type == TutorialType.UNTIL_SOUND_IS_PLAYING:
		var player = get_tree().root.get_node("MainRoot/Level/Level/Player")
		player.block_movement = false
