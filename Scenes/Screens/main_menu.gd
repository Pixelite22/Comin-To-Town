extends Node2D

signal play_button_pressed
signal quit_button_pressed

@onready var camera = $Camera2D

func _ready() -> void:
	pass

func _on_play_pressed() -> void:
	play_button_pressed.emit()
	hide()
	camera.enabled = false
	print("Main Menu Camera Enabled: ", camera.enabled)

func _on_quit_pressed() -> void:
	get_tree().quit()
