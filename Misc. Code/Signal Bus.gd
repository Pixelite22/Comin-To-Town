extends Node

signal santa_seen
signal santa_died
signal hit_death_barrier

@onready var main := $"../Test Scene"
@onready var game_over_screen := $"../Test Scene/Death Barrier"
@onready var Santa := $"../Test Scene/Santa"
@onready var children := $"../Test Scene/Children"

func _ready() -> void:
	children.connect("santa_seen", see_santa)
	Santa.connect("died", dead_santa)
	game_over_screen.connect("death_barrier_entered", death_barrier)

func see_santa():
	santa_seen.emit()

func dead_santa():
	print("Event Bus caught and emitting santa dying signal")
	santa_died.emit()

func death_barrier():
	hit_death_barrier.emit()
