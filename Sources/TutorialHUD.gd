@tool
extends Control

var tutorial = null

func fade_in():
	$AnimationPlayer.play("fadein")

func fade_out():
	$AnimationPlayer.play("fadeout")

func set_subtitle(text):
	$Panel/Label.text = text

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("skip_tutorial") && tutorial:
		tutorial.tutorial_skip()
