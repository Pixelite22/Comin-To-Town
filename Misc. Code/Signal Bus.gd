extends Node

signal santa_seen
signal santa_died
signal hit_death_barrier

@onready var main := $"../Main"
@onready var game_over_screen := $"../Main/Death Barrier"
@onready var Santa := $"../Main/Santa"
@onready var children := $"../Main/Children"

func _ready() -> void:
	children.connect("santa_seen", see_santa)
	Santa.connect("died", dead_santa)
	game_over_screen.connect("death_barrier_entered", dead_santa)

func see_santa():
	santa_seen.emit()

func dead_santa():
	print("Event Bus caught and emitting santa dying signal")
	santa_died.emit()

func death_barrier():
	hit_death_barrier.emit()
