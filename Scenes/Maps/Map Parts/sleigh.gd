extends Area2D

@export var gifts_held := 10

var gifts := []

@onready var gift_1 := load("res://Scenes/Maps/Map Parts/gifts.tscn")
@onready var gift_2 := load("res://Scenes/Maps/Map Parts/gifts.tscn")
@onready var gift_3 := load("res://Scenes/Maps/Map Parts/gifts.tscn")
@onready var gift_placement_1 := $"Gift Placement/Gift Place 1"
@onready var gift_placement_2 := $"Gift Placement/Gift Place 2"
@onready var gift_placement_3 := $"Gift Placement/Gift Place 3"
var gi1
var gi2
var gi3
var gift_ctr := 0

func _ready() -> void:
	gi1 = gift_1.instantiate()
	add_child(gi1)
	gi2 = gift_2.instantiate()
	add_child(gi2)
	gi3 = gift_3.instantiate()
	add_child(gi3)
	gi1.position = gift_placement_1.position
	gi2.position = gift_placement_2.position
	gi3.position = gift_placement_3.position
	gift_placement()



func gift_placement():
	if gifts_held >= 3:
		gi1.show()
		gi2.show()
		gi3.show()
	elif gifts_held == 2:
		gi1.show()
		gi2.show()
		gi3.hide()
	elif gifts_held == 1:
		gi1.show()
		gi2.hide()
		gi3.hide()
	elif gifts_held <= 0:
		gi1.hide()
		gi2.hide()
		gi3.hide()


func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		if body.gifts_held < 3:
			var gifts_needed = 3 - body.gifts_held
			if gifts_held >= gifts_needed:
				gifts_held -= gifts_needed
				body.gifts_held += gifts_needed
			elif gifts_held < gifts_needed:
				body.gifts_held += gifts_held
				gifts_held = 0
	
	gift_placement()
