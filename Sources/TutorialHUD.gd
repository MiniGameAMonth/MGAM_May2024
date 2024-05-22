@tool
extends Control

func fade_in():
	$AnimationPlayer.play("fadein")

func fade_out():
	$AnimationPlayer.play("fadeout")

func set_subtitle(text):
	$Panel/Label.text = text
