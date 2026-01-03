extends CharacterBody2D
class_name santa

signal died
signal powerup_unpause

@export_subgroup("Property Nodes")
@export var grav: gravity
@export var inp: input
@export var move: movement
@export var atk: attacks
@export var state_machine: stateMachine

@export_subgroup("Stats")
@export var speed = 100
@export var health := 1
@export var dead_flg := false
@export var gifts_held := clampi(0, 0, 3)


@export_subgroup("Power-Up Settings")
@export var jump_max := clampi(1, 1, 3)
@export var jump_ctr := 1
var times_jumped = clampi(0, 0, 3)
var hasGlided := false

#Power Up Flags
@export_subgroup("Power-Up Flags")
@export var glide := false
@export var double_jump := false
@export var triple_jump := false
@export var snowball := false
@export var powerup_choices = ["Glide", "Extra Jump", "Extra Jump", "Snowball"]
var powerup_choices_editable

#Nodes
@onready var sprite := $Sprite
@onready var sparkleSprite := $"Sprite/Sparkle Sprite"
@onready var collision := $Collision
@onready var inpnode := $Input
@onready var gravnode := $Gravity
@onready var movenode := $Movement
@onready var soundfx := $"Sound FX"
@onready var camera := $Camera2D
@onready var debug := $"Debug Info"
@onready var ui := $"Player UI"
@onready var power_up_menu := $"Powerup Menu"
var healthicons := []

func _ready() -> void: #When the node enters the game
	#Connect all these signals from the signal bus to relevent functions
	SignalBus.connect("santa_seen", damage)
	SignalBus.connect("game_unpaused", game_start_resume)
	SignalBus.connect("play_button_pressed", game_start_resume)
	SignalBus.connect("hit_death_barrier", death_handling)
	SignalBus.connect("cookie_collected", powerup_menu_call)
	
	healthbarinit() #initialize and set up health bar in the healthbarinit func
	powerup_choices_editable = powerup_choices.duplicate() #And duplicate the powerup_choices into powerup_choices_editable
	#So we can have an editable array, and a masterlist of all possible powerups

func _physics_process(_delta: float) -> void: #every physics frame
	grav.handleGravity(self, move.handleGlide(self, inp.glide(self), glide), _delta) #Run the handle gravity function
	
	move.handleMovementH(self, inp.inputH, speed, inp.sprint()) #run the handle horizontal movement functoin to check for attempts
	move.handleJump(self, inp.jump()) #run jump function to check fo jump attempts
	
	atk.snowball(self, direction(), inp.shoot(), snowball) #run snowball function to check for when the player tries using a snowball
	
	if is_on_floor(): #if the player is on the floor
		jump_ctr = jump_max #set the jump_ctr to whatever the jump_max value is at any given time
		times_jumped = 0 #set times jumped to 0
		hasGlided = false #and hasGlided flag to false
	
	
	move_and_slide() #move and slide magic function that does shit for stuff somehow

func direction(): #This function keeps track of which way the player faces, namely for things like snowball that needs to know which way to go in relation to him
	if sprite.flip_h == false: 
		return 1.0
	else:
		return -1.0

func healthbarinit(): #Initialize the health bar 
	for icon in ui.get_children(): #for nodes in the ui node
		if icon is Sprite2D: #if the node is a Sprite2D node (an icon)
			healthicons.append(icon) #append this node to the healthicons array
			icon.texture = load("res://Placeholder Art/UI Items/Health/Health Cane.png") #set the icon's img to the candycane

func healthbarupdate(): #Updates health bar, called after taking damage if called correctly
	if health >= 3: #If health is equal to 3
		#Set all icons to the candy cane image
		for icon in healthicons:
			icon.texture = load("res://Placeholder Art/UI Items/Health/Health Cane.png")
	elif health == 2:#If health is 2
		#Set the first (leftmost) icon to a broken candy cane, and the rest to full candycane
		healthicons[0].texture = load("res://Placeholder Art/UI Items/Health/Broken Candy Cane.png")
		healthicons[1].texture = load("res://Placeholder Art/UI Items/Health/Health Cane.png")
		healthicons[2].texture = load("res://Placeholder Art/UI Items/Health/Health Cane.png")
	elif health == 1: #if health is only 1
		#Set appropriate health icons
		healthicons[0].texture = load("res://Placeholder Art/UI Items/Health/Broken Candy Cane.png")
		healthicons[1].texture = load("res://Placeholder Art/UI Items/Health/Broken Candy Cane.png")
		healthicons[2].texture = load("res://Placeholder Art/UI Items/Health/Health Cane.png")
	elif health <= 0: #if no health left
		#set all icons to the broken candy cane
		for icon in healthicons: 
			icon.texture = load("res://Placeholder Art/UI Items/Health/Broken Candy Cane.png")

func damage(knockback := false, dmg := 1): #damage function
	if not dead_flg: #if the player isn't dead
		health -= dmg #subtract some health from the health stat
		healthbarupdate() #update the visual aspect of the health bar accordingly
#		if knockback:
#			pass #need to fill this spot here if we decide knockback is something fire should have or not
		if health <= 0: #if health reaches or goes under 0
			state_machine.state_transition("Dead") #transition to the death state
			death_handling() #and enter the death handling function

func death_handling(): #handles death
	if health != 0: #if health isn't 0, but this function was still reached somehow,
		health = 0 #set health to 0
	healthbarupdate() #Update the health bar to reflect the new 0 health
	died.emit() #emit death signal
	dead_flg = true #set dead flag to true


func _on_main_game_paused() -> void: #when the game is paused
	camera.enabled = false #disable the camera 
	#debug.hide() #hide the debug menu 

func game_start_resume(): #when the resume button is pressed during the game_start
	camera.enabled = true #enable the player camera
	
	state_reset()
	
	#if not debug.is_visible_in_tree(): #if the debug menu isn't visible
	#	debug.show() #show it

func powerup_menu_call(): #powerup menu call
	power_up_menu.random_choice(powerup_choices_editable) #call the random choice function in the power up menu
	power_up_menu.show() #and show it

func _on_powerup_menu_powerup_chosen(powerup: Variant, powerup_not_chosen) -> void: #when a powerup is chosen, this is called
	#find the chosen powerup
	if powerup == "Glide":
		if not glide: #if the glide flag is false
			glide = true #set it to true
	elif powerup == "Extra Jump":
		if jump_max < 3: #If the max jump isn't 3 or over
			jump_max += 1 #add one to the max
			jump_ctr = jump_max #Set the jump counter to the jump max for the player 
	elif powerup == "Snowball":
		if not snowball: # if the snowball flag isn't chosen
			snowball = true # Set it to true
	else: #Or if nothing isn't chosen
		pass #Pass through the function
	
	
	
	powerup_choices_editable.append(powerup_not_chosen) #and add the unchosen powerup to the array it came from
	powerup_unpause.emit()
	state_reset()


func _on_game_over_screen_retry_button_pressed() -> void: #if the game over screen's retry button is pressed
	camera.enabled = false #disable the player camera so the main menu camera can take over

func state_reset():
		#To avoid getting stuck on a state after unpausing, set the player to falling or idle depending on placement
	if is_on_floor(): #if the player is on the floor
		state_machine.state_transition("Idle") #Set state to idle
	#note: We shouldn't need one for being in the air as, they will stay in the air, meaning almost any of those states are still fair
	
