extends Node2D

signal play_button_pressed
signal quit_button_pressed

@onready var camera = $Camera2D

func _on_play_pressed() -> void: #when the play button is pressed
	play_button_pressed.emit() #emit the play button pressed signal
	hide() #hide the screen
	camera.enabled = false #and disable the camera so the view can pass to another camera

func _on_quit_pressed() -> void: #when the quit button is pressed
	get_tree().quit() #quit the game
