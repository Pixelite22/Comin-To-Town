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

@export_subgroup("Power-Up Settings")
@export var jump_max := clampi(1, 1, 3)
@export var jump_ctr := 1
var times_jumped = clampi(0, 0, 3)
var hasGlided := false

#Power Up Flags
var glide := false

@onready var sprite := $Sprite
@onready var sparkleSprite := $"Sprite/Sparkle Sprite"
@onready var collision := $Collision
@onready var inpnode := $Input
@onready var gravnode := $Gravity
@onready var movenode := $Movement
@onready var soundfx := $"Sound FX"
@onready var camera := $Camera2D
@onready var debug := $"Debug Info"

func _ready() -> void:
	SignalBus.connect("santa_seen", damage)
	SignalBus.connect("game_unpaused", game_start_resume)
	SignalBus.connect("play_button_pressed", game_start_resume)
	SignalBus.connect("hit_death_barrier", death_handling)
	SignalBus.connect("cookie_collected", powerup_enabling)

func _physics_process(_delta: float) -> void: #every physics frame
	grav.handleGravity(self, move.handleGlide(self, inp.glide(self), glide), _delta) #Run the handle gravity function
	
	move.handleMovementH(self, inp.inputH, speed, inp.sprint()) #run the handle horizontal movement functoin to check for attempts
	move.handleJump(self, inp.jump()) #run jump function to check fo jump attempts
	
	if is_on_floor():
		jump_ctr = jump_max
		times_jumped = 0
		hasGlided = false
	
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
	debug.hide()

func game_start_resume():
	camera.enabled = true
	print("Player Camera Enabled: ", camera.enabled)
	if not debug.is_visible_in_tree():
		debug.show()

func powerup_enabling():
	print("Santa caught cookie collected signal")
	#in the future this will call a function that will open a menu to allow choice of power up but for now
	if jump_max < 3:
		jump_max += 1
		jump_ctr = jump_max
	if not glide:
		glide = true
