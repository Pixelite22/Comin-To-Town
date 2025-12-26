extends AnimatableBody2D

var direction

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position.x += 15 * direction



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		print("Snowball hit a kid")
		#SignalBus.snowball_hit.emit()
		body.stunned()
		queue_free()
