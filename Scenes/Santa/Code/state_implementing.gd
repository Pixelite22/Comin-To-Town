extends State
class_name PlayerState

#define states as seperate consts now.  Not enum
const IDLE : String = "Idle"
const WALKING : String = "Walking"
const RUNNING : String = "Running"
const SLIDING : String = "Sliding"
const JUMPING : String = "Jumping"
const FALLING : String = "Falling"
const DEAD : String = "Dead"

var player: santa

func _ready() -> void:
	await owner.ready #await the owner of node being ready
	player = owner as santa #make sure the owner is a santa node
	assert(player != null, "Owner must be a santa node") #and if it isn't, sput out an error telling us to make it one
