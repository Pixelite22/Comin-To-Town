extends PlayerState

var play_speed 
var play_jump_velocity

func enter(prev_state: String, data := {}): #When state is entered
	print(self.name + " State Entered from ", prev_state)
	player.sprite.play(self.name) #run the animation that shares the name with the state
	play_speed = player.speed #set play_speed to player speed so we can remember it if needed
	player.speed = 0 #set speed to 0 so they can't move
	play_jump_velocity = player.move.jumpVelocity #set play_jump_velocity to players jumpVelocity to remember if needed
	player.move.jumpVelocity = 0 #Set it to 0 so they can't jump

func exit(): #If and when exiting this state
	player.speed = play_speed #set speed back to normal
	player.move.jumpVelocity = play_jump_velocity #set jump back to normal
