extends CharacterBody2D
class_name santa

@export_subgroup("Property Nodes")
@export var grav: gravity
@export var inp: input
@export var move: movement

@onready var sprite := $Sprite

func _ready() -> void:
	sprite.play("Idle")

func _physics_process(_delta: float) -> void:
	grav.handleGravity(self, _delta)
	
	move.handleMovementH(self, inp.inputH, inp.sprint())
	move.handleJump(self, inp.jump())
	
	move_and_slide()
