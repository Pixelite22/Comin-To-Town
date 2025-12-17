extends CharacterBody2D
class_name santa

signal died

@export_subgroup("Property Nodes")
@export var grav: gravity
@export var inp: input
@export var move: movement
@export var state_machine: stateMachine

@export_subgroup("Stats")
@export var speed = 100
@export var health := 1
@export var dead_flg := false

@onready var sprite := $Sprite
@onready var collision := $Collision
@onready var inpnode := $Input
@onready var gravnode := $Gravity
@onready var movenode := $Movement
@onready var soundfx := $"Sound FX"
@onready var camera := $Camera2D

func _ready() -> void:
	SignalBus.connect("santa_seen", damage)
	SignalBus.connect("game_unpaused", game_start_resume)
	SignalBus.connect("play_button_pressed", game_start_resume)
	SignalBus.connect("hit_death_barrier", death_handling)

func _physics_process(_delta: float) -> void: #every physics frame
	grav.handleGravity(self, _delta) #Run the handle gravity function
	
	move.handleMovementH(self, inp.inputH, speed, inp.sprint()) #run the handle horizontal movement functoin to check for attempts
	move.handleJump(self, inp.jump()) #run jump function to check fo jump attempts
	
	move_and_slide() #move and slide magic function that does shit for stuff somehow

func damage():
	if not dead_flg:
		health -= 1
		print("Santa Health: ", health)
		if health <= 0:
			state_machine.state_transition("Dead")
			death_handling()

func death_handling():
	died.emit()
	dead_flg = true


func _on_main_game_paused() -> void:
	camera.enabled = false
	print("Player Camera Enabled: ", camera.enabled)

func game_start_resume():
	camera.enabled = true
	print("Player Camera Enabled: ", camera.enabled)
