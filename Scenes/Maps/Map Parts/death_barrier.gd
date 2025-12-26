extends Area2D

signal death_barrier_entered

func _on_body_entered(body: Node2D) -> void: #If a body hits the barrier
	if body.is_in_group("Player"): #if the body is a player
		death_barrier_entered.emit() #emit the death barrier entered signal
