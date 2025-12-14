extends Node

signal santa_seen

@onready var main := $"../Test Scene"
@onready var Santa := $"../Test Scene/Santa"
@onready var children := $"../Test Scene/Children"

func _ready() -> void:
	children.connect("santa_seen", see_santa)

func see_santa():
	santa_seen.emit()
