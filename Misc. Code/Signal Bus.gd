extends Node

signal santa_seen
signal santa_died
signal hit_death_barrier
signal game_paused
signal game_unpaused
signal play_button_pressed
signal cookie_collected
signal tree_full
signal powerup_chosen(powerup, not_chosen)
signal threw_snowball(dir)
signal snowball_hit
signal retry_requested

@onready var main := $"../Main"
@onready var Santa := $"../Main/Santa"
@onready var children := $"../Main/Children"
@onready var pause_screen := $"../Main/Pause Menu"
@onready var main_menu := $"../Main/Main Menu"
@onready var death_barrier := $"../Main/Death Barrier"
@onready var cookie := $"../Main/Cookies and Milk"
@onready var tree := $"../Main/Tree"
@onready var powerup_menu := $"../Main/Santa/Powerup Menu"
@onready var game_over_screen := $"../Main/Santa/Game Over Screen"


func _ready() -> void:
	children.connect("santa_seen", see_santa)
	Santa.connect("died", dead_santa)
	death_barrier.connect("death_barrier_entered", death_barrier_handling)
	pause_screen.connect("game_unpaused", unpause)
	main_menu.connect("play_button_pressed", play)
	cookie.connect("cookie_collected", collected)
	tree.connect("tree_full", filled)
	powerup_menu.connect("powerup_chosen", choose_powerup)
	game_over_screen.connect("retry_button_pressed", retry)

func see_santa():
	santa_seen.emit()

func dead_santa():
	santa_died.emit()

func death_barrier_handling():
	hit_death_barrier.emit()

func pause():
	game_paused.emit()

func unpause():
	game_unpaused.emit()

func play():
	play_button_pressed.emit()

func collected():
	print("Event Bus caught and emitting cookie_collected signal")
	cookie_collected.emit()

func filled():
	tree_full.emit()

func choose_powerup(powerup, powerup_not_chosen):
	powerup_chosen.emit(powerup, powerup_not_chosen)

func retry():
	retry_requested.emit()
