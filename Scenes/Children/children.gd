extends CharacterBody2D

@export_subgroup("Property Nodes")
@export var grav: gravity
@export var move: movement

@export_subgroup("Stats")
@export var speed = 50

#Nodes
@onready var Sprite = $Sprite
@onready var Collision_Handling = $"Collision Handling"
@onready var BCollide = $"Collision Handling/Body Collision"
@onready var VCollide = $"Collision Handling/Vision Collision"
@onready var timer = $Timer

var directflag := 1.0
var see_santa : bool = false

func _ready() -> void:
	timer.start(5)
	Sprite.play("Walking")

func _physics_process(delta: float) -> void:
	move.handleMovementH(self, directflag, speed, false)
	
	move_and_slide()


func _on_collision_handling_body_entered(body: Node2D) -> void:
	see_santa = true

func _on_collision_handling_body_exited(body: Node2D) -> void:
	see_santa = false


func _on_timer_timeout() -> void:
	if Sprite.flip_h:
		Sprite.flip_h = false
		VCollide.rotation_degrees += 180
	else:
		Sprite.flip_h = true
		VCollide.rotation_degrees -= 180
	
	directflag *= -1
