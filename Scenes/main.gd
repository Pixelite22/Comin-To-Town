extends Node2D

signal game_paused

@onready var Santa := $Santa
@onready var tree := $Tree
@onready var debug := $"Santa/Debug Info"
@onready var game_over_screen := $"Santa/Game Over Screen"
@onready var pause_menu := $"Pause Menu"
@onready var main_menu := $"Main Menu"
#@onready var EBus := $"../Event Bus"
@onready var level_complete := $"Santa/Level Beat Screen Placeholder"
@onready var path1 = $Pathing
@onready var path2 = $Pathing2
@onready var path3 = $Pathing3
@onready var path_follow1 = $Pathing/PathFollow2D
@onready var path_follow2 = $Pathing2/PathFollow2D
@onready var path_follow3 = $Pathing3/PathFollow2D
@onready var child1 = $Children
@onready var child2 = $Children2
@onready var child3 = $Children3
@onready var children := [] 
@onready var pathing := []
@onready var path_following := []

var pause_menu_enabled := false
var pausable := true

var snowball_scene := preload("res://Scenes/items/snowball.tscn")

var direction := 1

func _ready() -> void: #on loadin of the game
	if not main_menu.is_visible_in_tree(): #if the main menu can't be seen
		main_menu.show() #show it
	
	main_menu.camera.enabled = true #make sure we are looking through the main menu camera
	get_tree().paused = true #and pause the game so it doesn't start too soon
	
	#connect the neccissary signals from the signal bus from various parts of the project
	#As this is main, I more then likely could have found a way to get these without using the signal bus
	#but i had just figured it out this project, and got a little excited
	SignalBus.connect("cookie_collected", powerup_pause)
#	SignalBus.connect("powerup_chosen", powerup_unpause)
	SignalBus.connect("threw_snowball", snowball_thrown)
	SignalBus.connect("retry_requested", restart)
	
	array_assignment()

func array_assignment():
	for child_node in get_children():
		if child_node is Path2D:
			pathing.append(child_node)
			for follow in child_node.get_children():
				if follow is PathFollow2D:
					path_following.append(follow)
					for kid in follow.get_children():
						if kid is CharacterBody2D and kid.is_in_group("Enemies"):
							children.append(kid)
	
	print(children)
	print(path_following)
	print(pathing)


func _process(delta: float) -> void: #every frame
	#Display a debug info on the top right of the screen.  We will eventually remove or comment out this text
	#debug.text = "Debug Info: \nSeen By Child: " + str(children.see_santa) + "\nReached Tree: " + str(tree.tree_reached) + "\nCurrent Santa State: " + str(Santa.state_machine.state.name) + "\nSanta's Health: " + str(Santa.health) + "\nJump Counter: " + str(Santa.jump_ctr) + "\nGifts Held: " + str(Santa.gifts_held) + "\n Power-Up's left: " + str(Santa.powerup_choices_editable.size())
	
	#If the player is trying to pause the game
	if Input.is_action_pressed("Pause") and not pause_menu_enabled and pausable:
		game_paused.emit() #emit the pause signal
		pause_menu_enabled == true #and mark the pause menu enabled flag to true
	
	#if children.size() == path_following.size():
	#	for child in range(children.size()):
	#		children[child].position = path_following[child].position
	
	if children.size() == path_following.size():
		for i in range(path_following.size()):
			if not children[i].stun:
				path_following[i].progress_ratio += direction * delta * 0.1
				
				if path_following[i].progress_ratio >= 1.0:
					children[i].Sprite.flip_h = false
					path_following[i].progress_ratio = 1.0
					direction = -1
				elif path_following[i].progress_ratio <= 0.0:
					children[i].Sprite.flip_h = true
					path_following[i].progress_ratio = 0.0
					direction = 1
			else:
				pass

func _on_game_paused() -> void: #Function called when game is paused
	pause_menu.show() #show the pause menu
	get_tree().paused = true #and puase the game
	
	await get_tree().create_timer(1) #wait for a second
	
	pause_menu.unpauseable = true #and set the unpauseable flag to true
	
	#Note: I do not remember why I am waiting that second but I am too scared to take it out now


func _on_pause_menu_game_unpaused() -> void: #Function accessed when game is unpaused 
	pause_menu.hide() #Hide the pause menu
	get_tree().paused = false #unpause the game

func _on_main_menu_play_button_pressed() -> void: #When the main menu's play button is pressed
	#main_menu.hide()
	get_tree().paused = false #Unpause the game
	Santa.camera.enabled = true #and make the camera being used the one connected to the santa player

func _on_santa_died() -> void: #Called when Santa dies
	pausable = false #Set the pausability of the game to false

func _on_sleigh_level_completed() -> void: #When Santa touches the slegih to complete the level
	#In the future this will hopefully trigger a cutscene to take the player to the next level but for now
	level_complete.show() #show the level complete text

func _on_fire_body_entered(body: CharacterBody2D) -> void: #When Santa touches the fire in anyway
	Santa.damage(true, 2) #Call the damage function from the santa script to deal two damage to santa

func powerup_pause(): #connected in ready and called when the cookie collected signal is activated
	get_tree().paused = true #Pause the game to allow for choosing of powerup safely
	

func powerup_unpause(): #connected in ready and called when a powerup is chosen from the menu
	get_tree().paused = false #Unpuase the game so the player can keep playing

func snowball_thrown(dir): #connected in ready and called when a snowball powerup is thrown by the player
	var snowball_instance = snowball_scene.instantiate() #instantiate a new snowball scene
	snowball_instance.position = Santa.position #set it's postion equal to that of the player
	snowball_instance.direction = dir #set it's direction equal to the direction passed into the function
	add_child(snowball_instance) #add the snowball we have set up to the tree

func restart(): #connected in ready and called when the player is trying to restart the game, currently just from the game over screen
	get_tree().reload_current_scene() #reload the scene tree, actively restarting the game
	Santa.camera.make_current() #make sure the current camera is on Santa.  I do not know why this works as it should make the camera on the main menu and then on santa... but hey, it works, so who am i to question except the guy who made this entire thing
