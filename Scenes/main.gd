extends Node2D

signal game_paused

@onready var Santa := $Santa
@onready var children := $Children
@onready var tree := $Tree
@onready var debug := $"Santa/Debug Info"
@onready var game_over_screen := $"Santa/Game Over Screen"
@onready var pause_menu := $"Pause Menu"
@onready var main_menu := $"Main Menu"
#@onready var EBus := $"../Event Bus"
@onready var level_complete := $"Santa/Level Beat Screen Placeholder"

var pause_menu_enabled := false
var pausable := true

func _ready() -> void:
	if not main_menu.is_visible_in_tree():
		main_menu.show()
	
	main_menu.camera.enabled = true
	get_tree().paused = true


func _process(delta: float) -> void:
	debug.text = "Debug Info: \nSeen By Child: " + str(children.see_santa) + "\nReached Tree: " + str(tree.tree_reached) + "\nCurrent Santa State: " + str(Santa.state_machine.state.name) + "\nSanta's Health: " + str(Santa.health) + "\nJump Counter: " + str(Santa.jump_ctr) + "\nGifts Held: " + str(Santa.gifts_held)
	if Input.is_action_pressed("Pause") and not pause_menu_enabled and pausable:
		game_paused.emit()
		pause_menu_enabled == true

func _on_game_paused() -> void:
	pause_menu.show()
	get_tree().paused = true
	
	await get_tree().create_timer(1)
	
	pause_menu.unpauseable = true


func _on_pause_menu_game_unpaused() -> void:
	pause_menu.hide()
	get_tree().paused = false

func _on_main_menu_play_button_pressed() -> void:
	#main_menu.hide()
	get_tree().paused = false

func _on_santa_died() -> void:
	pausable = false

func _on_sleigh_level_completed() -> void:
	level_complete.show()

func _on_fire_body_entered(body: CharacterBody2D) -> void:
	Santa.damage(true, 2)
