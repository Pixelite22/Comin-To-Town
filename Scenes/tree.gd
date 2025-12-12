extends Area2D
class_name goal

var tree_reached := false

func _physics_process(_delta: float) -> void:
	pass

func _on_body_entered(_body: CharacterBody2D) -> void:
	tree_reached = true

func _on_body_exited(body: Node2D) -> void:
	tree_reached = false
