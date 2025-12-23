extends Area2D
class_name goal

signal presents_fully_placed
signal tree_full

var tree_reached := false
var gifts := []

@onready var gift_scene := load("res://Scenes/Maps/Map Parts/gifts.tscn")
@onready var gift_placement_1 := $"Gift Placement/Placement 1"
@onready var gift_placement_2 := $"Gift Placement/Placement 2"
@onready var gift_placement_3 := $"Gift Placement/Placement 3"
var gift_ctr := 0
var full := false

func _physics_process(_delta: float) -> void:
	pass

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		tree_reached = true
		if body.gifts_held >= 0 and not full:
			if body.gifts_held >= 3:
				body.gifts_held -= 3
				gift_placement(3)
			elif body.gifts_held == 2:
				body.gifts_held = 0
				gift_placement(2)
			elif body.gifts_held == 1:
				body.gifts_held = 0
				gift_placement(1)
			else:
				pass

func _on_body_exited(body: Node2D) -> void:
	tree_reached = false

func gift_placement(amount):
	for gift in range(amount):
		gifts.append(gift_scene.instantiate())
		add_child(gifts[gift])
	
	for gift in gifts:
		gift_ctr += 1
		if gift_ctr == 1:
			gift.position = gift_placement_1.position
		if gift_ctr == 2:
			gift.position = gift_placement_2.position
		if gift_ctr == 3:
			gift.position = gift_placement_3.position
			full = true
			tree_full.emit()
