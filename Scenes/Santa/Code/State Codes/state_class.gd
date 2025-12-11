#Base Class for all states
#Class will be extended and code overridden to future states
extends Node
class_name State

signal state_ended(next_state: String, data: Dictionary)


#Called on entering the state
func enter(prev_state: String, data := {}) -> void:
	pass

#Called on leaving the state
func exit() -> void:
	pass

#Called by the state machine on every tick of engine's main loop
func update(_delta) -> void:
	pass

#Called by the state machine on every tick of the engine's physics update
func physics_update(_delta) -> void:
	pass

#Handleds needed inputs 
func handle_input(_event: InputEvent):
	pass
