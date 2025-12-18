extends Area2D

signal cookie_collected

#func _ready() -> void:
#	SignalBus.cookie_collected.connect(collected)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		SignalBus.cookie_collected.emit()
		queue_free()
