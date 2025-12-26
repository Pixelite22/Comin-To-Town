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


var directflag := 1.0 #flag for chosing a direction 
var see_santa : bool = false

func _ready() -> void: #on ready
	SignalBus.snowball_hit.connect(stunned)
	
	timer.start(5) #start the timer and let it countdown for 5 seconds
	Sprite.play("Walking") #and start playing the walking animation

func _physics_process(delta: float) -> void:
	move.handleMovementH(self, directflag, speed, false) #call the handle movement node passing itself, the direction flag, the speed, and a false for sprinting
	
	move_and_slide() #The mystical magical move_and_slide


func _on_collision_handling_body_entered(body: Node2D) -> void: #if child collides with another 2d body
	if body.is_in_group("Player"): #if the body is in the player group (the player)
		see_santa = true #Set see_santa to true for the debug menu
		SignalBus.santa_seen.emit() #emit the santa_seen signal from the SignalBus (Something I didn't even really know was possible)


func _on_collision_handling_body_exited(body: Node2D) -> void: #If a body leaves the collision
	see_santa = false #make see_santa false


func _on_timer_timeout() -> void: #When the timer node reaches 0
	#Turn the sprite around by flipping the sprite and rotating the collision by 180 degrees from whatever it last was
	if Sprite.flip_h: 
		Sprite.flip_h = false
		VCollide.rotation_degrees += 180
	else:
		Sprite.flip_h = true
		VCollide.rotation_degrees -= 180
	
	#Make the child travel backward
	directflag *= -1

func stunned():
	BCollide.disabled = true
	VCollide.disabled = true
	var regspeed = speed
	speed = 0
	Sprite.play("Fell Over")
	
	await get_tree().create_timer(2.0).timeout
	
	Sprite.play("Picking self up")
	
	await get_tree().create_timer(2.0).timeout
	
	Sprite.play("Walking")
	BCollide.disabled = false
	VCollide.disabled = false
	speed = regspeed
