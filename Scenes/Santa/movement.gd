extends Node
class_name movement

@export_subgroup("Settings")
@export var speed = 100
@export var jumpVelocity = -350.0

var hammerAvailable = true
#@onready var timer = $Timer

var isJumping = false

func handleMovementH(body, direction, sprint):
	body.velocity.x = direction * speed
	if sprint:
		body.velocity.x *= 2

func handleJump(body, wantToJump):
	if wantToJump and body.is_on_floor(): #if wnat to jump is true and character is on a floor
		body.velocity.y = jumpVelocity #jump at jump velocity
		
		isJumping = body.velocity.y < 0 and not body.is_on_floor() #Sets isJumping to true when velocity is less then 0 and the character is not detected as on the floor.
