extends Node2D

signal game_paused

@onready var Santa := $Santa
@onready var children := $Children
@onready var tree := $Tree
@onready var debug := $"Debug Info"
@onready var game_over_screen := $"Game Over Screen"
@onready var pause_menu := $"Pause Menu"
#@onready var EBus := $"../Event Bus"

var pause_menu_enabled := false

func _process(delta: float) -> void:
	debug.text = "Debug Info: \nSeen By Child: " + str(children.see_santa) + "\nReached Tree: " + str(tree.tree_reached) + "\nCurrent Santa State: " + str(Santa.state_machine.state.name) + "\nSanta's Health: " + str(Santa.health)
	if Input.is_action_pressed("Pause") and not pause_menu_enabled:
		game_paused.emit()
		pause_menu_enabled == true


func _on_children_santa_seen() -> void:
	print("Santa Seen Signal Recieved")

func _on_game_paused() -> void:
	pause_menu.show()
	get_tree().paused = true
	await get_tree().create_timer(1)
	
	pause_menu.unpauseable = true


func _on_pause_menu_game_unpaused() -> void:
	pause_menu.hide()
	get_tree().paused = false
