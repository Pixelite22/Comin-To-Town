extends Node
class_name stateMachine

var _state: State

#variable for initial state
@export var init_state: State

#Current State
@onready var state: State: #get = get_init_state #Use getter function
	get: return _state if _state != null else init_state if init_state != null else get_child(0) as State
	set(value):
		_state = value

func get_init_state() -> State: #Getter function for variable
	return init_state if init_state != null else get_child(0) as State #return the initial state, as long as it exists, if it doesn't, get the first state

func _ready() -> void: #on ready
	for state_nodes: State in find_children("*", "State"): #for the state nodes that are children of the state machine node
		state_nodes.state_ended.connect(state_transition) #connect the state_ended signal to the state_transition function
		print(state_nodes.name, "'s signal connected!") #and output signal connected to the compiler to make sure we know it worked
	
	await owner.ready #wait owner being ready, synching to state class
	state.enter(" ") #Enter the initial node

#Function to transition states
func state_transition(target: String, data: Dictionary = {}):
	print("State Transition Reached")
	if not has_node(target): #if the target isn't a node
		printerr(owner.name + ": Trying to transition to state " + target + " but it doesn't exist.") #print error showing that it isnt a node
		return #return early
	
	#if target == str(state):
	var prev_state := state.name #initialize previous state variable
	state.exit() #exit current state
	state = get_node(target) as State #make current state target, assuming it is a node and of class State
	print("Resolved node for ", target, ": ", state.name)
	
	state.enter(prev_state, data) #enter the state, passing the previous state and whatever data it recieved from it to the new one

#if there is an unhandled input
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event) #Send the input to the state

#check every tick
func _process(delta: float) -> void:
	state.update(delta) #update the state, for uses needed to be updated this often

#Check every physics tick
func _physics_process(delta: float) -> void:
	state.physics_update(delta) #update the state, for uses needed to be updated this often
