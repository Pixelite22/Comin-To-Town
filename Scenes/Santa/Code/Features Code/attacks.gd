extends Features
class_name attacks


#function for the snowball attack, looking for the body the snowballs will shoot from, the direction they
#should shoot towards, the signal for wanting to shoot, and the flag for if they are able to
func snowball(body, direction, want_to_shoot, able): 
	if able and want_to_shoot: #if the character has the able flag and want's to shoot
		SignalBus.threw_snowball.emit(direction) #emit the signal from the signal bus
