extends Node2D

signal game_unpaused

@onready var camera = $Camera2D
@onready var resume_button = $Resume
@onready var options_button = $Options
@onready var quit_button = $Quit

var unpauseable : bool = false

#func _ready() -> void:
#	SignalBus.connect("santa_died", disable_pause)
#	SignalBus.connect("hit_death_barrier", disable_pause)

#func _process(delta: float) -> void:
#	if Input.is_action_pressed("Unpause") and unpauseable:
#		unpause()

func _on_main_game_paused() -> void:
	camera.zoom.x = 1.0 / scale.x
	camera.zoom.y = 1.0 / scale.y
	camera.enabled = true

func unpause():
	game_unpaused.emit()
	camera.enabled = false
	print("Pause Menu Camera Enabled: ", camera.enabled)
	disable_pause()

func disable_pause():
	unpauseable = true

func _on_resume_pressed() -> void:
	unpause()

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	pass
