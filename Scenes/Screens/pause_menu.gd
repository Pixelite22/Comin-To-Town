extends Node2D

signal game_unpaused

@onready var camera = $Camera2D
@onready var resume_button = $Resume
@onready var options_button = $Options
@onready var quit_button = $Quit

var unpauseable : bool = false

func _on_main_game_paused() -> void: #when the game is paused
	#Zoom out the camera to view full map
	#No longer useful due to new pause menu design, 
	#still keeping as comment as it doesn't hurt anything and may be used again in a future pause menu redesign
#	camera.zoom.x = 1.0 / scale.x 
#	camera.zoom.y = 1.0 / scale.y
	camera.enabled = true #enable the pause camera

func unpause():
	game_unpaused.emit() #emit the unpause symbol
	camera.enabled = false #disable the pause camera
	disable_pause() #run the following disable pause function

func disable_pause():
	unpauseable = true #set unpauseable to true

func _on_resume_pressed() -> void: #When the resume button is pressed
	unpause() #unpause the game by calling the unpause function

func _on_options_pressed() -> void: #when the optinos are pressed (Not filled out yet as I haven't come up with needed options
	pass # Replace with function body.

func _on_quit_pressed() -> void: #When the quit button is pressed, 
	get_tree().quit() #Quit the game
