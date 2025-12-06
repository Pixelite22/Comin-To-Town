extends Node
class_name stateMachine

#variable for initial state
@export var init_state: State

#Current State
@onready var state: State : get = get_init_state

func get_init_state() -> State:
	return init_state if init_state != null else get_child(0) as State

func _ready() -> void:
	for state_nodes in find_children("*", "State"):
		state_nodes.state_ended.connect(state_transition)
		print(state_nodes.name, "'s signal connected!")
		
		await owner.ready
		state.enter(" ")

func state_transition(target: String, data: Dictionary = {}):
	if not has_node(target):
		printerr(owner.name + ": Trying to transition to state " + target + " but it doesn't exist.")
		return
	
	var prev_state := state.name
	state.exit()
	state = get_node(target) as State
	state.enter(prev_state, data)

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)
