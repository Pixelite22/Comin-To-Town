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

func disable_feature(feature):
	print("disable_feature reached")
	if feature == input:
		player.remove_child(player.inpnode)
	elif feature == gravity:
		player.remove_child(player.gravnode)
	elif feature == movement:
		print("Trying to disable movement")
		player.remove_child(player.movenode)

func reenable_feature(feature):
	print("reenable_feature reached")
	if feature == input:
		player.add_child(player.inpnode)
	elif feature == gravity:
		player.add_child(player.gravnode)
	elif feature == movement:
		player.add_child(player.movenode)
