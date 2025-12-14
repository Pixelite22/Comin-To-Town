extends Node2D

@onready var Santa := $Santa
@onready var children := $Children
@onready var tree := $Tree
@onready var debug := $"Debug Info"
@onready var game_over_screen := $"Game Over Screen"

func _process(delta: float) -> void:
	debug.text = "Debug Info: \nSeen By Child: " + str(children.see_santa) + "\nReached Tree: " + str(tree.tree_reached) + "\nCurrent Santa State: " + str(Santa.state_machine.state.name)



func _on_children_santa_seen() -> void:
	print("Santa Seen Signal Recieved")
	if Santa.health <= 0:
		await get_tree().create_timer(2.5).timeout
	
		game_over_screen.show()
