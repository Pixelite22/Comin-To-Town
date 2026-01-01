extends AnimatableBody2D

var direction

func _physics_process(delta: float) -> void: 
	position.x += 15 * direction #every physics frame, the snowball travels 15 in the x direction faced by santa



func _on_area_2d_body_entered(body: Node2D) -> void: #if the snowball enters a collision for an area_body_2d
	if body.is_in_group("Enemies"): #if the collision belongs to a node in the enemies group
		body.stunned() #stun the enemy
		queue_free() #Despawn the snowball
