extends Features
class_name gravity

@export_subgroup("Settings")
@export var gravityForce = 1000.0

var is_falling = false

func handleGravity(body : CharacterBody2D, delta): #Fundtion handles gravity
	if not body.is_on_floor(): #If the character body isn't on the floor
		body.velocity.y += gravityForce * delta #add the gravity to the character until they land
	
	is_falling = body.velocity.y > 0 and not body.is_on_floor() #sets isFalling flag if body ix falling and not onn ground
