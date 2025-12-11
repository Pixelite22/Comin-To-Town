extends CharacterBody2D
class_name santa

@export_subgroup("Property Nodes")
@export var grav: gravity
@export var inp: input
@export var move: movement
@export var state_machine: stateMachine

@onready var sprite := $Sprite
@onready var collision := $Collision
@onready var inpnode := $Input
@onready var gravnode := $Gravity
@onready var movenode := $Movement

#func _ready() -> void:
#	sprite.play("Idle")

func _physics_process(_delta: float) -> void: #every physics frame
	grav.handleGravity(self, _delta) #Run the handle gravity function
	
	move.handleMovementH(self, inp.inputH, inp.sprint()) #run the handle horizontal movement functoin to check for attempts
	move.handleJump(self, inp.jump()) #run jump function to check fo jump attempts
	
	move_and_slide() #move and slide magic function that does shit for stuff somehow
