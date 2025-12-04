extends Area2D
class_name goal

func _physics_process(_delta: float) -> void:
	pass

func _on_body_entered(_body: CharacterBody2D) -> void:
	print("Tree Touched!")
