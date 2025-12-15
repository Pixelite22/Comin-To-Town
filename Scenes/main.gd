extends Node2D

@onready var Santa := $Santa
@onready var children := $Children
@onready var tree := $Tree
@onready var debug := $"Debug Info"
@onready var game_over_screen := $"Game Over Screen"
#@onready var EBus := $"../Event Bus"

func _process(delta: float) -> void:
	debug.text = "Debug Info: \nSeen By Child: " + str(children.see_santa) + "\nReached Tree: " + str(tree.tree_reached) + "\nCurrent Santa State: " + str(Santa.state_machine.state.name) + "\nSanta's Health: " + str(Santa.health)



func _on_children_santa_seen() -> void:
	print("Santa Seen Signal Recieved")
