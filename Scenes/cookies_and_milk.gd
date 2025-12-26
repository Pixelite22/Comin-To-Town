extends Area2D

signal cookie_collected

#func _ready() -> void:
#	SignalBus.cookie_collected.connect(collected)

func _on_body_entered(body: Node2D) -> void: #When a cookie is grabbed
	if body.is_in_group("Player"): #If the player grabbed it
		SignalBus.cookie_collected.emit() #emit the cookie_collected signal from the SignalBus
		queue_free() #Destroy this cookie
