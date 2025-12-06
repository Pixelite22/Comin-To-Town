extends State
class_name PlayerState

#define states as seperate consts now.  Not enum
const IDLE := "Idle"
const WALKING := "Walking"
const RUNNING := "Running"
const SLIDING := "Sliding"
const JUMPING := "Jumping"
const FALLING := "Falling"
const DEAD := "Dead"

var player: santa

func _ready() -> void:
	await owner.ready
	player = owner as santa
	assert(player != null, "Owner must be a santa node")
