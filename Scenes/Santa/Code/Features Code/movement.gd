extends Features
class_name movement

@export_subgroup("Settings")
@export var jumpVelocity = -500.0

var hammerAvailable = true
#@onready var timer = $Timer

var isJumping = false

func handleMovementH(body, direction, speed, sprint): #This function handles horizontal movement, taking in the body moving, the direction to move to, the speed of movement, and whether they are sprinting or not
	body.velocity.x = direction * speed #direction is an int of 1 or -1, so multiplying it by the speed sets the direction and speed
	if sprint: #if pressing the sprint button
		body.velocity.x *= 2 #double the velocity of the character

func handleJump(body, wantToJump): #Function handles jumping, taking into account the body trying to jump, and whether it wants to
	if wantToJump and body.jump_ctr > 0: #body.is_on_floor(): #if wnat to jump is true and character is on a floor
		body.velocity.y = jumpVelocity #jump at jump velocity
		
		isJumping = body.velocity.y < 0 and not body.is_on_floor() #Sets isJumping to true when velocity is less then 0 and the character is not detected as on the floor.

func handleGlide(body, holdingGlide, ableToGlide): #handles Gliding, taking the body to glide, whether they are holding the glide button, and if they are allowed to
	if holdingGlide and not body.is_on_floor() and ableToGlide: #If the holding glide flag is true and the body isn't on the floor and they are allowed to glide
		if body.velocity.y >= 0: #and body's moving down
			return true #return a true flag
