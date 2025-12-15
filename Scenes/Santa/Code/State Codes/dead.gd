extends PlayerState

var play_speed
var play_jump_velocity

func enter(prev_state: String, data := {}): #When state is entered
	print(self.name + " State Entered from ", prev_state)
	player.sprite.play(self.name) #run the animation that shares the name with the state
	play_speed = player.speed
	player.speed = 0
	play_jump_velocity = player.move.jumpVelocity
	player.move.jumpVelocity = 0

func exit():
	player.speed = play_speed
	player.move.jumpVelocity = play_jump_velocity
