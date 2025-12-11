extends Features
class_name input

var inputH = 0.0

func _process(_delta: float) -> void:
	inputH = Input.get_axis("Left", "Right")

func jump():
	return Input.is_action_just_pressed("Jump")

func slide():
	return Input.is_action_just_pressed("Slide")

func sprint():
	return Input.is_action_pressed("Sprint")
