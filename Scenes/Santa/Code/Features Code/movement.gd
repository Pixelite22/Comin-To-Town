extends Features
class_name movement

@export_subgroup("Settings")
@export var jumpVelocity = -500.0

var hammerAvailable = true
#@onready var timer = $Timer

var isJumping = false

func handleMovementH(body, direction, speed, sprint):
	body.velocity.x = direction * speed #direction is an int of 1 or -1, so multiplying it by the speed sets the direction and speed
	if sprint: #if pressing the sprint button
		body.velocity.x *= 2 #double the velocity of the character

func handleJump(body, wantToJump):
	if wantToJump and body.jump_ctr > 0: #body.is_on_floor(): #if wnat to jump is true and character is on a floor
		body.velocity.y = jumpVelocity #jump at jump velocity
		
		isJumping = body.velocity.y < 0 and not body.is_on_floor() #Sets isJumping to true when velocity is less then 0 and the character is not detected as on the floor.

func handleGlide(body, holdingGlide, ableToGlide):
	if holdingGlide and not body.is_on_floor() and ableToGlide:
		if body.velocity.y >= 0:
			return true
