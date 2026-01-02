extends CharacterBody2D

signal santa_seen

#Connect the relevant, premade nodes
@export_subgroup("Property Nodes")
@export var grav: gravity
@export var move: movement

#Editable stats
@export_subgroup("Stats")
@export var speed = 50

#Nodes
@onready var Sprite = $Sprite
@onready var Collision_Handling = $"Collision Handling"
@onready var BCollide = $"Collision Handling/Body Collision"
@onready var VCollide = $"Collision Handling/Vision Collision"
@onready var timer = $Timer


var stun := false
var directflag := 1.0 #flag for chosing a direction 
var see_santa : bool = false

func _ready() -> void: #on ready
	SignalBus.snowball_hit.connect(stunned)
	
	Sprite.play("Walking") #and start playing the walking animation

func _physics_process(delta: float) -> void:
#	move.handleMovementH(self, directflag, speed, false) #call the handle movement node passing itself, the direction flag, the speed, and a false for sprinting
	
	move_and_slide() #The mystical magical move_and_slide


func _on_collision_handling_body_entered(body: Node2D) -> void: #if child collides with another 2d body
	if body.is_in_group("Player"): #if the body is in the player group (the player)
		see_santa = true #Set see_santa to true for the debug menu
		SignalBus.santa_seen.emit() #emit the santa_seen signal from the SignalBus (Something I didn't even really know was possible)


func _on_collision_handling_body_exited(body: Node2D) -> void: #If a body leaves the collision
	see_santa = false #make see_santa false

#function fo stunning the NPC
func stunned():
	collision_disable()
	stun = true #Set the speed to 0
	Sprite.play("Fell Over") #and finally play the animation for falling over
	
	await get_tree().create_timer(2.0).timeout #Then wait two seconds
	
	Sprite.play("Picking self up") #play the animation for picking themselves up
	
	await get_tree().create_timer(2.0).timeout #wait two more seconds
	
	Sprite.play("Walking") #Start playing the walking animation again
	collision_enable()
	stun = false


func collision_disable():
	BCollide.set_deferred("disabled", true) #disable body collision
	VCollide.set_deferred("disabled", true) #disable vision collision


func collision_enable():
	BCollide.set_deferred("disabled", false) #enable body collision
	VCollide.set_deferred("disabled", false) #enable vision collision
