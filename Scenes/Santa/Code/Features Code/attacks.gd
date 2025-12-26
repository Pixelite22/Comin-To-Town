extends Features
class_name attacks

func snowball(body, direction, want_to_shoot, able):
	if able and want_to_shoot:
		SignalBus.threw_snowball.emit(direction)
		print("threw_snowball signal emitted")
