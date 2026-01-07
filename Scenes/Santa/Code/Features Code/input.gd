extends Features
class_name input

var inputH = 0.0

#For the most part, this code is to set flags on the player script
#The player calls these functions when needed to provide either boolian outputs for certain features like jumping and gliding
#Or positive and negative integers for walking and running

#Constantly check for if the player is pressing left or right
func _process(_delta: float) -> void:
	inputH = Input.get_axis("Left", "Right") #Set inputH to the axis between Left and Right.  For buttons this doesn't do much but I think it would change things on an analog stick

#Jump Function
func jump():
	return Input.is_action_just_pressed("Jump") #Return the jump input

#Gliding Function
#Knowing that the jump could switch between true and false, we might be able to refactor this code
func glide(player: CharacterBody2D):
	if player.times_jumped == player.jump_max: #If the time's the player jumped is the same as the set maximum jumps
		return Input.is_action_pressed("Jump") #Return the jump input
	else: #otherwise
		return false 

#Sliding function
func slide():
	return Input.is_action_just_pressed("Slide") #Return whether the slide input is true or not

#Sprint function
func sprint():
	return Input.is_action_pressed("Sprint") #Return whether the sprint button is being pressed

#Shooting function
func shoot():
	return Input.is_action_just_pressed("Shoot") #Return whether the shooting buttin was just pressed

func invis():
	return Input.is_action_just_pressed("Invisible")
