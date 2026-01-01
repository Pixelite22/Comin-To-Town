extends Features
class_name gravity

@export_subgroup("Settings")
@export var normalGravityForce = 1000.0 #preset for normal gravity
var glidingGravityForce = normalGravityForce / 4 #Preset for gliding gravity
var gravityForce #Gravity Force the player will use

var is_falling = false

func handleGravity(body : CharacterBody2D, isGliding, delta): #Function handles gravity
	if not body.is_on_floor(): #If the character body isn't on the floor
		if isGliding: #and body.velocity.y > 0: #if the character has the gliding flag on and has an upwards velocity
			gravityForce = glidingGravityForce #Make Gravity glidinggravity
		else: #Otherwise,
			gravityForce = normalGravityForce #make gravity normal
		
		body.velocity.y += gravityForce * delta #add the gravity to the character until they land
	
	is_falling = body.velocity.y > 0 and not body.is_on_floor() #sets isFalling flag if body ix falling and not onn ground
