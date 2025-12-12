extends Node2D

@onready var Santa := $Santa
@onready var children := $Children
@onready var tree := $Tree
@onready var debug := $"Debug Info"

func _process(delta: float) -> void:
	debug.text = "Debug Info: \nSeen By Child: " + str(children.see_santa) + "\nReached Tree: " + str(tree.tree_reached) + "\nCurrent Santa State: " + str(Santa.state_machine.state.name)
