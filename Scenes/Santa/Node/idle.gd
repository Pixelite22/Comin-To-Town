extends PlayerState

func enter(prev_state: String, data := {}):
	player.velocity.x = 0.0
	player.sprite.play(self.name)

func physics_update(_delta):
#	player.velocity.y += player.gravity * _delta
#	player.move_and_slide()
	
	if not player.is_on_floor():
		state_ended.emit(FALLING)
	elif Input.is_action_just_pressed("Jump"):
		state_ended.emit(JUMPING)
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		state_ended.emit(RUNNING)
