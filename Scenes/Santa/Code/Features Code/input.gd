extends Features
class_name input

var inputH = 0.0

#For the most part, this code is to set flags on the player script
#The player calls these functions when needed to provide either boolian outputs for certain features like jumping and gliding
#Or positive and negative integers for walking and running

func _process(_delta: float) -> void:
	inputH = Input.get_axis("Left", "Right")

func jump():
	return Input.is_action_just_pressed("Jump")

func glide(player: CharacterBody2D):
	if player.times_jumped == player.jump_max:
		return Input.is_action_pressed("Jump")
	else:
		return false

func slide():
	return Input.is_action_just_pressed("Slide")

func sprint():
	return Input.is_action_pressed("Sprint")

func shoot():
	return Input.is_action_just_pressed("Shoot")
